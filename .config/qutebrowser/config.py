# imports
import theme.spill

# Theme Stuff
theme.spill.paint(c,{
    'spacing':{
        'vertical':6,
        'horizontal':8
    }
})

# c.content.user_stylesheets = [ 'css/personal.css' ]
config.set('content.javascript.enabled', False)

# Load automatic config
config.load_autoconfig()
config.source('./redirectors.py')
