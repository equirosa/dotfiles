# imports
import dracula.draw

config.load_autoconfig()

#Dracula Stuff
dracula.draw.blood(c,{
    'spacing':{
        'vertical':6,
        'horizontal':8
    }
})

c.content.user_stylesheets = [ 'css/solarized_dark.css' ]
config.set('content.javascript.enabled', False)
