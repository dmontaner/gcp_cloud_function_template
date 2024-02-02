# main.tf
# 2024-01-31 david.montaner@gmail.com
# deploy GCP cloud function using Terraform

# See for roles:
# https://cloud.google.com/functions/docs/reference/iam/roles

# See for iam permits
# https://github.com/hashicorp/terraform-provider-google/issues/5833#issuecomment-1918906933

# See for archive_file 
# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file
# The issue is that the archive_file resource creates a file during the plan phase and not the apply phase.

locals {
  # PARAMETERS
  project       = "{{ cookiecutter.project }}"
  region        = "{{ cookiecutter.region }}"
  function_name = "{{ cookiecutter.function_name }}"
  entry_point   = "{{ cookiecutter.entry_point }}"
  source        = "{{ cookiecutter.source }}"

  # INTERNAL VARIABLES
  src_zip = "source_code_${local.function_name}.zip"
  tmp_zip = "/tmp/${local.src_zip}"
  bucketn = "${local.project}-source-code-${local.function_name}"
}


provider "google" {
  project = local.project
  region  = local.region
}


# SOURCE CODE
data "archive_file" "tmp_zip" {
  type        = "zip"
  source_dir  = "../${local.source}"
  output_path = local.tmp_zip
}

resource "google_storage_bucket" "bucket" {
  name     = local.bucketn
  location = local.region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "object" {
  bucket = google_storage_bucket.bucket.name
  name   = local.src_zip
  source = data.archive_file.tmp_zip.output_path
}


# CLOUD FUNCTION
resource "google_cloudfunctions2_function" "function" {
  name        = local.function_name
  location    = local.region
  description = "GCP function deployed using Terraform"

  service_config {
    max_instance_count = 1
    available_memory   = "128Mi"
    timeout_seconds    = 60
  }
  
  build_config {
    runtime     = "python311"
    entry_point = local.entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }
}


{%- if cookiecutter.allow_unauthenticated -%}
# ACCESS FOR ALL
resource "google_cloudfunctions2_function_iam_member" "cloud_function_invoker_all" {
  project        = local.project
  location       = local.region
  cloud_function = google_cloudfunctions2_function.function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}

resource "google_cloud_run_service_iam_member" "cloud_run_invoker_all" {
  project  = local.project
  location = local.region
  service  = google_cloudfunctions2_function.function.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

{%- else -%}
# RESTRICTED ACCESS
resource "google_service_account" "service_account" {
  account_id   = "sa-${local.function_name}"
  display_name = "sa-${local.function_name}"
  description  = "Service account to safely run the cloud function ${local.function_name}"
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.service_account.name
}

resource "local_file" "service_account_key_json_file" {
  content  = "${base64decode(google_service_account_key.key.private_key)}"
  filename = "../tests/sa-${local.function_name}-key.json"
}

resource "google_cloudfunctions2_function_iam_member" "cloud_function_invoker" {
  project        = local.project
  location       = local.region
  cloud_function = local.function_name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_cloud_run_service_iam_member" "cloud_run_invoker" {
  project  = local.project
  location = local.region
  service  = local.function_name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.service_account.email}"
}

output "service_account_email" {
  value = google_service_account.service_account.email
}
{% endif %}

output "function_uri" { 
  value = google_cloudfunctions2_function.function.service_config[0].uri
}
