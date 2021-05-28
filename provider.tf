provider "google" {
  projet =  var.project_id
  credentials =  "cpt_teste.json"
  region   =  "us-east1 "
  zone     =  var.zone
}
