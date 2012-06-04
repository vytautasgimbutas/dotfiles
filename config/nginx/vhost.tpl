server {
  listen         80;
  server_name     .domain.tld;

  index           index.php;
  root            /Projects/domain.tld;

location ~ "^(.+\.php)($|/)" {
    fastcgi_split_path_info ^(.+\.php)(.*)$;
 
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param SCRIPT_NAME $fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;

    include fastcgi_params;
    fastcgi_pass 127.0.0.1:9000;
  }
}