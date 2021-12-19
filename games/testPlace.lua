local m = {}

function m:Init(win)
    local abctest = win:Tab('domah')
    local label = abctest:Label('balls lololololol')
    local textBox = abctest:Textbox('yo',false,function(text)
        label:Edit(text)
    end)
end

return m
