# imports
import theme.spill

config.load_autoconfig()

# Theme Stuff
theme.spill.paint(c,{
    'spacing':{
        'vertical':6,
        'horizontal':8
    }
})

# c.content.user_stylesheets = [ 'css/personal.css' ]
config.set('content.javascript.enabled', False)
