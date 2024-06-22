mnt = Project.find_or_create_by!(symbol: "mnt") do |c|
  c.name = "Momentum"
  c.stage = "pre-sale"
  c.repository_url = "https://github.com/momentum-foundation/momentum"
end

# mnt.whitepaper.attach(io: File.open("db/seed/whitepapers/momentum.pdf"), filename: "momentum-whitepaper.pdf")
