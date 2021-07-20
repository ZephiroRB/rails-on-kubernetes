namespace :docker do
  desc "Push docker images to DockerHub"
  task :push_image do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t zephirotube/rails-demo:#{TAG} ."

    IMAGE_ID = `docker images | grep zephirotube\/rails-demo | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} zephirotube/rails-demo:latest"

    puts "Pushing Docker image"
    sh "docker push zephirotube/rails-demo:#{TAG}"
    sh "docker push zephirotube/rails-demo:latest"

    puts "Done"
  end

end
