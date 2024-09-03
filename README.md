# Dumb fixes for dumb problems

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

__Q__: But wont this service eat my system resources and waste cpu cycles on a useless task?<br>
__A__: Yes it will. Same as everything else in this world. In practice how ever, it is negligible

__Q__: But isn't it wasteful and inefficient to just check if value have changed every 5 seconds?<br>
__A__: Yes it is. And I don't care. It works. Sue me.

Also you will need to change the service to start with your greeter at [this line](./fix-changing-values/set-data-in-loop.service?plain=1#L3) and set the values in the [script itself](./fix-changing-values/watch-and-set) to what you actually need.

After that you shove the service into your `$HOME/.config/systemd/user/` folder and start it. Now enjoy your life, knoing that this abomination is running in the background.

### Dumb fix for שג not being monospaced properly and overlapping in alacritty
#### Disclaimer: This chapter assumes that you're using `Nerd Font Symbols` aswell, but they are not necessary and can be safely ignored and/or commented out, if you want to.

This one is especially retarded (As all things should be). If you're using alacritty and your font of preference doesn't support a language you need, alacritty will fallback on the monospace font (or whatever linux thinks your default monospace font is) and _sometimes_ your monospace font won't be so monospace with __some__ laguages.

That's why שג might be crooked. So to fix this abomination of an issue, you'll need to provide the system with a different fallback. That's were [10-retarded-monospace.conf](./10-retarded-monospace.conf) comes in.

It basically provides the system with a different fallback for a font you want to use.

Honestly this solution is actually not that retarded, it more of the whole problem being insanely retarded.

To apply this fix, you need to do the following setps:

- 1 You need a folder `$HOME/.config/fontconfig` to exist and layedout [as per arch wiki article](https://wiki.archlinux.org/title/Font_configuration#Presets)
- 2 You also need to copy `50-user.conf` and `51-local.conf` from `/usr/share/fontconfig/conf.default` into `$HOME/.config/fontconfig/conf.d`
- 3 Find a font that is not fucked for you that you'll use as a fallback
- 4 Copy the `10-retarded-monospace.conf` into the `$HOME/.config/fontconfig/conf.d`
- 5 Now edit your `10-retarded-monospace.conf` file:
    - 5.1 Change the `family` of the font on the [ 9th line ](./10-retarded-monospace.conf?plane=1#L9) to the name of your primary font. In my case it was `Roboto Mono`
      - 5.1.1 If your font requires it, do the same for every variation of your font, such as `Light`, `Medium`, `SemiBold`, `Thin` etc...
      Mine does, that's why there's so much duplication. It might not be required and you might get away with not providing these, but I'll leave theme there in case anyone ever needs them.
   - 5.2 Change the `family` of the font on the [ 5th line ](./10-retarded-monospace.conf?plane=1#L5) to the name of your fallback font
   - 5.3 Change the `prefered family` of the font on the [ 10th line ](./10-retarded-monospace.conf?plane=1#L10) to the name of your fallback font
   - 5.3.1 Do the same for every variation of your primary font, if you need to do so (see 5.1.1)
 - 6 Profit. Now restart alacritty and (hopefully) enjoy an unfucked monospace.
