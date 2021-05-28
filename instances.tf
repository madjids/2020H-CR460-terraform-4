resource "google_compute_instance" "chien" {
  name         = "chien"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["public"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-dmz.name
    access_config {

    }
  }


  metadata_startup_script = "apt-get -y update && apt-get -y upgrade && apt-get -y install apache2 && systemctl start apache2"

  
  # Un Health-Check HTTP complet vérifiera le serveur aux 4 secondes, une instance deviendra healthy après 5 succès et unhealthy après 3 échecs
}

# si non trouvé fedora-coreos-stable
resource "google_compute_instance" "chat" {
  name         = "chat"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["interne"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-stable"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-interne.name
    access_config {

    }
  }
# cette instance doit pouvoir accepter publiquement les connexions par ssh
# cette instance doit pouvoir recevoir du trafic TCP sur les ports "4444", "5126", seulement en provenance du sous-réseau "prod-traitement"

}

resource "google_compute_instance" "hamster" {
  name         = "hamster"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["traitement"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-stable"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.prod-traitement.name

  }

# ces instances doivent pouvoir s'éteindre automatiquement jusqu'à un minimum d'une instance ET
# ces instances doivent pouvoir se mettre en fonction automatiquement jusqu'à un maximum de cinq instances SELON
# une évaluation de la charge du CPU à +/- 53% après un délai de démarrage de 3 minutes
}

# 16 non disponible
resource "google_compute_instance" "perroquet" {
  name         = "perroquet"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["cage"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  network_interface {
     network = "default"
   }
}
