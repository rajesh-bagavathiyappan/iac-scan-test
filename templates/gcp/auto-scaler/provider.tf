provider "google" {
  project = "cloudmatos-demoblog"
}

provider "google-beta" {
  #credentials = "${file("account.json")}"
  project = "cloudmatos-demoblog"
}