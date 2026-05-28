# Demo PR: adds a Pub/Sub topic + a Vertex AI endpoint to the dev environment.
# Both require IAM permissions the deployer SA does not currently hold —
# iam-legend should post a review identifying:
#   - pubsub.topics.create  → roles/pubsub.admin or roles/pubsub.publisher
#   - aiplatform.endpoints.create  → roles/aiplatform.user

resource "google_pubsub_topic" "agent_events" {
  name    = "iam-legend-demo-agent-events"
  project = var.project_id
}

resource "google_pubsub_subscription" "agent_events_sub" {
  name    = "iam-legend-demo-agent-events-sub"
  topic   = google_pubsub_topic.agent_events.name
  project = var.project_id
}

resource "google_vertex_ai_endpoint" "demo_endpoint" {
  name         = "iam-legend-demo-endpoint"
  display_name = "iam-legend Demo Endpoint"
  location     = "us-central1"
  project      = var.project_id
}
