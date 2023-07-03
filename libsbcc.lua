local libsbcc = {}

function libsbcc.quit()
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
end

return libsbcc