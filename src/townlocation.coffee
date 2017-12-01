money = 0
safe = 0
current = ->
townchoose = ->
  switch
    when lvl >= 3 then displayToPlayer '=TOWN= Work, fix, sell, safe, beach, forest, cave =TOWN='
    when lvl == 2 then displayToPlayer '=TOWN= Work, fix, sell, safe, beach, forest =TOWN='
    else displayToPlayer '=TOWN= Work, fix, sell, safe, beach =TOWN='
  current = ->
    switch question.toUpperCase()
      when 'WORK' then choosework()
      when 'FIX'
        displayToPlayer "Fixing your rod will cost you #{rod} money. Are you sure?"
        current = ->
          switch question.toUpperCase()
            when 'YES'
              if money >= rod
                money -= rod
                rod = 0
                displayToPlayer "You have #{money} money and #{rod} dmg!"
                setTimeout (-> townchoose()), 2000
              else
                displayToPlayer 'Not enough money'
                setTimeout (-> townchoose()), 2000
            when 'NO' then townchoose()
      when inventory.length >= 1 and 'SELL'
        displayToPlayer "your items are: #{inventory.join(', ')}. Sell?"
        current = ->
          switch
            when 'YES'
              money += inventory.length * 2.5
              inventory.length = 0
              displayToPlayer "You have sold all your items. Your money is #{money}."
              setTimeout (-> townchoose()), 2000
            when 'NO'
              setTimeout (-> townchoose()), 2000
      when inventory.length < 1 and 'SELL'
        displayToPlayer 'You have no items in your inventory..'
        setTimeout (-> townchoose()), 1800
      when 'STATS' then showme()
      when 'BEACH' then beachchoose()
      when  lvl >= 2 and 'FOREST'
        displayToPlayer 'We are on our way to the enchanted forest.......'
        setTimeout (-> forestchoose()), 1500
      when lvl >= 3 and 'CAVE'
        displayToPlayer 'We are on our way to the cave.......'
        setTimeout (-> cavechoose()), 1500
      when 'SAFE'
        displayToPlayer 'Store your money or recover it?'
        current = ->
          switch question.toUpperCase()
            when 'STORE'
              if money >= 1
                safe += money
                money = 0
                displayToPlayer 'You stored all your money in the safe'
                setTimeout (-> townchoose()), 1500
              else
                displayToPlayer 'You have no money!'
                setTimeout (-> townchoose()), 1500
            when 'RECOVER'
              if safe >= 1
                money += safe
                safe = 0
                displayToPlayer 'You recovered all your money from the safe'
                setTimeout (-> townchoose()), 1500
              else
                displayToPlayer 'There is nothing in the safe!'
                setTimeout (-> townchoose()), 1500
      else
        displayToPlayer 'Thats not an option'
choosework = ->
  random = Math.random() * 10 + 1
  switch
    when random <= 2
      displayToPlayer "You go to the library and help out with storing while you've gained experience from reading. Also you get paid"
      money += 25
      xp += 1
      console.log "You have #{xp}xp! Money: #{money}"
      check()
      setTimeout (-> townchoose()), 2500
    when random >= 8
      displayToPlayer 'While looking for a job you get robbed. You lose 10 money!'
      money -= 10
      check()
      console.log "Money: #{money}"
      setTimeout (-> townchoose()), 2500
    when random <= 4
      displayToPlayer 'You work at the pub and get paid 15 money!'
      money += 15
      console.log "Money:  #{money}"
      setTimeout (-> townchoose()), 2500
    when random <= 7
      displayToPlayer 'You go to the local car wash and gain some experience!'
      xp += 1
      console.log "You have #{xp}xp!"
      check()
      setTimeout (-> townchoose()), 2500
    else
      displayToPlayer 'No one wants to hire you! Tough luck.'
      setTimeout (-> townchoose()), 2500
