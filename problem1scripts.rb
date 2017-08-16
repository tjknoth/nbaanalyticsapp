# NBA Analytics hackathon application scripts
# Tristan Knoth

# Probability that team avoids consecutive losses

def probNoConsecutiveLosses(pwin, games)
  p = probNoConsecutiveLossesKernel(pwin, games)
  puts "The probability of playing a #{games}-game season without consecutive losses is #{p.round(6)}"
end

def probNoConsecutiveLossesKernel(pwin, games)

  lim = (games / 2).ceil
  prob = 0
  for losses in 0..lim
    d = choose(games - losses + 1, losses) * ((1 - pwin) ** losses) * (pwin ** (games - losses))
    prob += d
  end
  prob
end

# recursive implementation of the choose function
def choose(n, k)
  return 1 if (k == 0)
  return (n * choose(n - 1, k - 1)) / k
end

# Finds the minimum probability of winning each individual game (accurate to .0001, but modifiable)
#  such that a team is more likely than not to avoid consecutive losses
def probToAvoidConsecutiveLosses (games)
  pwin = 0.8 # We know that at 0.8, the team has only a ~6% chance of avoiding back to back losses
  delta = 0.0001

  while pwin <= 1 do
    if probNoConsecutiveLossesKernel(pwin, games) > 0.5
      puts "If a team wins #{(pwin * 100).round(4)}% of games, there is a \>50% chance they will avoid consecutive losses in an #{games}-game season."
      break
    else
      pwin += delta
    end
  end

end
