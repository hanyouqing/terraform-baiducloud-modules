module "cfc" {
  source = "../../"

  functions = {
    hello = {
      function_name = "demo-hello"
      description   = "Basic CFC hello"
      handler       = "index.handler"
      runtime       = "nodejs18"
      time_out      = 30
      memory_size   = 128
      code_file_dir = "${path.module}/src"
    }
  }

  project     = "demo"
  environment = "development"
}
