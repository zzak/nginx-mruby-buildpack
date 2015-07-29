class Web
  def initialize
    @request = Nginx::Request.new
    @request.content_type = "text/html"
  end

  def run
    header
    body
    footer
  end

  def header
    Nginx.rputs "<!DOCTYPE html>
    <html>
    <head>
      <meta charset='utf-8' />
      <link rel='stylesheet' type='text/css' href='/public/style.css' />
    </head>
    <body>
    "
  end

  def body
    Nginx.rputs "<h2>Hello, ngx_mruby!</h2>"
  end

  def footer
    Nginx.rputs "</body></html>"
  end
end

Web.new.run
