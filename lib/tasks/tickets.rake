namespace :tickets do
    desc "Process tickets (; separator)"
    task :all, [:client_ids, :date_from, :date_to] => [:environment] do |t, args|
      args.with_defaults(client_ids: nil, date_from: nil, date_to: nil)
    end  
end
  