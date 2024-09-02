# Dumb fixes for dumb problems

## about:
### What is this?
This repo is a collection of stupidly easy (not smart mind you) fixes, for very dumb problems that I've encountered and didn't feel like diging into.

### Why is it in the internet?
Because I need to keep track of them

### Can I do X with them?
Please consult the [license](LICENSE.md)

## List of current contents:
### Dumb fix for steam fucking with xrandr settings and discord fucking with the microphone volume
I hate this so much, but this shit basically launches with system as a [systemd-service](./fix-changing-values/set-data-in-loop.service), and then just checks if the values have changed every 5 seconds.
You could also do it with crone, but I don't care enough to do so.

Also you will need to change the service to start with your greeter at [this line](./fix-changing-values/set-data-in-loop.service?plain=1#L2) and set the values in the [file itself](./fix-changing-values/watch-and-set) to what you actually need.

After that you shove the service into your `$HOME/.config/systemd/user/` folder and start it. Now enjoy your life, knoing that this abomination is running in the background.
