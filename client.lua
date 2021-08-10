-- made by nirosten

local open = false
local mainMenu = RageUI.CreateMenu("Dev Tool", "Liberty city")
mainMenu.Closed = function()
    open = false
    RageUI.Visible(mainMenu, false)
end

local Checked = {
    east = true,
    jersey = true,
    manhat = true,
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
                            Checked.east = true
                            for k,v in pairs(eastZone) do
                                local min, max = v.extends[1], v.extends[2]
                                RequestIpl(v.name)
                            end
                        end,
                        onUnChecked = function()
                            Checked.east = false
                            for k,v in pairs(eastZone) do
                                local min, max = v.extends[1], v.extends[2]
                                RemoveIpl(v.name)
                            end
                        end,
                    })

                    RageUI.Checkbox("Activate jersey zone", nil, Checked.jersey, {}, {
                        onChecked = function()
                            Checked.jersey = true
                            for k,v in pairs(jerseyZone) do
                                local min, max = v.extends[1], v.extends[2]
                                RequestIpl(v.name)
                            end
                        end,
                        onUnChecked = function()
                            Checked.jersey = false
                            for k,v in pairs(jerseyZone) do
                                local min, max = v.extends[1], v.extends[2]
                                RemoveIpl(v.name)
                            end
                        end
                    })

                    RageUI.Checkbox("Activate manhat zone", nil, Checked.manhat, {}, {
                        onChecked = function()
                            Checked.manhat = true
                            for k,v in pairs(manhatZone) do
                                local min, max = v.extends[1], v.extends[2]
                                RequestIpl(v.name)
                            end
                        end,
                        onUnChecked = function()
                            Checked.manhat = false
                            for k,v in pairs(manhatZone) do
                                local min, max = v.extends[1], v.extends[2]
                                RemoveIpl(v.name)
                            end
                        end
                    })
                end)
                Wait(1)
            end
        end)
    end
end

Keys.Register("F1", "F1", "dev tool menu", function()
    openDevToolMenu()
end)