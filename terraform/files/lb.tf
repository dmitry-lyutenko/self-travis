resource "google_compute_instance_group" "reddit-ig" {
  name = "reddit-ig"
  zone = "${var.zone}"

  named_port {
    name = "puma-service"
    port = "${var.app_port}"
  }

  instances = ["${google_compute_instance.app.*.self_link}"]
}

resource "google_compute_http_health_check" "reddit-hc" {
  name               = "reddit-hc"
  check_interval_sec = 5
  timeout_sec        = 5
  request_path       = "/"
  port               = "${var.app_port}"
}

resource "google_compute_backend_service" "reddit-bs" {
  name      = "reddit-bs"
  port_name = "puma-service"
  protocol  = "HTTP"

  backend = {
    group = "${google_compute_instance_group.reddit-ig.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.reddit-hc.self_link}"]
}

resource "google_compute_url_map" "reddit-lb" {
  name            = "reddit-lb"
  default_service = "${google_compute_backend_service.reddit-bs.self_link}"
}

resource "google_compute_target_http_proxy" "reddit-tp" {
  name    = "reddit-tp"
  url_map = "${google_compute_url_map.reddit-lb.self_link}"
}

#resource "google_compute_target_tcp_proxy" "reddit-tcp-proxy" {
#  name = "reddit-tcp-proxy"
#  backend_service = "${google_compute_backend_service.reddit-bs.self_link}"
#}

resource "google_compute_global_forwarding_rule" "reddit-fr" {
  name       = "reddit-fr"
  port_range = "80"

  #region = "${var.region}"
  target = "${google_compute_target_http_proxy.reddit-tp.self_link}"

  #backend_service = "${google_compute_backend_service.reddit-bs.self_link}"
}
