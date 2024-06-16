mnt = Project.find_or_create_by!(symbol: "MNT") do |c|
  c.name = "Momentum"
  c.stage = "pre-sale"
end

# mnt.whitepaper.attach(io: File.open("db/seed/whitepapers/momentum.pdf"), filename: "momentum-whitepaper.pdf")
