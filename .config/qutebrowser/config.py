# imports
import theme.draw

config.load_autoconfig()

# Theme Stuff
theme.draw.paint(c,{
    'spacing':{
        'vertical':6,
        'horizontal':8
    }
})

c.content.user_stylesheets = [ 'css/solarized_dark.css' ]
config.set('content.javascript.enabled', False)
