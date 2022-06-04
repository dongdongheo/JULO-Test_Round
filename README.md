After deploying a lab with 1 Nginx server (run as service) & a combination of Prometheus and Grafana (run as Docker container) on another single VM/node; the next processing steps for this article are:
1) Check to make sure that the http_stub_status_module is already available by
	nginx -V 2>&1| grep -o http_stub_status_module
2) Add a route handler to expose the status page of nginx, add below configuration to the Nginx site config file.
	location /status {
           stub_status;
    }
3) Download the nginx_prometheus_exporter:
	wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.10.0/nginx-prometheus-exporter_0.10.0_linux_amd64.tar.gz
4) Extract the downloaded file and jump into the appropriate folder and execute:
	nohup ./nginx-prometheus-exporter -nginx.scrape-uri=http://localhost:80/status > nohup.out &
5) [On Prometheus server side] Add target to the prometheus.yml file (path in this lab is prometheus-grafana/prometheus/prometheus.yml):
	- job_name: 'nginx'
      static_configs:
       - targets: ['nginx_host_IP:listened_port_in_nohup.out_file_from_4th_step']
6) Restart prometheus service (in this case is to down && up the Prometheus & Grafana compose)
7) Download the JSON formatted dashboard for Nginx (link: https://grafana.com/grafana/dashboards/11199) and import the dashboard file onto Grafana.
