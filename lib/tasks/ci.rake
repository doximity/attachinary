# frozen_string_literal: true

namespace :ci do
  desc "Run specs"
  task :specs do
    Dir.chdir("spec/dummy") do
      sh "rails db:migrate"
    end
    reports = "tmp/test-results/rspec"
    sh "mkdir -p #{reports}"
    sh "bundle exec rspec ./spec " \
          "--format progress "\
          "--format RspecJunitFormatter " \
          "-o #{reports}/results.xml"
  end
end
