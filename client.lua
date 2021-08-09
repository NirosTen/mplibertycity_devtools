local open = false
local mainMenu = RageUI.CreateMenu("Dev Tool", "Liberty city")
mainMenu.Closed = function()
    open = false
    RageUI.Visible(mainMenu, false)
end

local Checked = {
    east = false
}

function openDevToolMenu()
    if open then
        open = false
        RageUI.Visible(mainMenu, false)
    else
        open = true
        RageUI.Visible(mainMenu, true)

        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Checkbox("Activate east zone", nil, Checked.east, {}, {
                        onChecked = function()
                            east = true
                            print("Open")
                        end,
                        onUnChecked = function()
                            east = false
                            print("Close")
                        end
                    })
                end)
            end
        end)
    end
end

Keys.Register("F1", "F1", "dev tool menu", function()
    openDevToolMenu()
end)