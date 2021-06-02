# ################################################################################
#                          Provider Settings
# ################################################################################
provider "google" {
    alias = "provider_01"
    project = var.projects["ADNS_Project_01"]
    # credentials = file("./Keys/gcp_key_01.json")

    # Optional Parameters - Which can be used as Global Defaults
    region = "us-central1"
    zone = "us-central1-c"
}

provider "google" {
    alias = "provider_02"
    project = var.projects["ADNS_Project_02"]
    # credentials = file("./Keys/gcp_key_02.json")

    # Optional Parameters - Which can be used as Global Defaults
    region = "us-central1"
    zone = "us-central1-c"
}

provider "google" {
    alias = "provider_03"
    project = var.projects["ADNS_Project_03"]
    # credentials = file("./Keys/gcp_key_03.json")

    # Optional Parameters - Which can be used as Global Defaults
    region = "us-central1"
    zone = "us-central1-c"
}

provider "google" {
    alias = "provider_04"
    project = var.projects["ADNS_Project_04"]
    # credentials = file("./Keys/gcp_key_04.json")

    # Optional Parameters - Which can be used as Global Defaults
    region = "us-central1"
    zone = "us-central1-c"
}
