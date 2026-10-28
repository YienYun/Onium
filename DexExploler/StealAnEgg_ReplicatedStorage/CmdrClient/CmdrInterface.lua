-- Script path: ReplicatedStorage.CmdrClient.CmdrInterface
-- Decompile time: 6.07 ms

local LocalPlayer = game:GetService("Players").LocalPlayer
return function(a1) -- Line: 6 -- upvalues: LocalPlayer (val)
    local Util = a1.Util
    local Window = require(script:WaitForChild("Window"))
    Window.Cmdr = a1
    local u17 = require(script:WaitForChild("AutoComplete"))(a1)
    Window.AutoComplete = u17

    function Window.ProcessEntry(a1_2) -- Line: 17 -- upvalues: Util (val), Window (val), a1 (val), LocalPlayer (upval)
        local v1 = Util.TrimString(a1_2)
        if #v1 == 0 then
            return
        end
        Window:AddLine((Window:GetLabel()) .. " " .. v1, (Color3.fromRGB(255, 223, 93)))
        Window:AddLine((a1.Dispatcher:EvaluateAndRun(v1, LocalPlayer, {IsHuman = true})))
    end

    function Window.OnTextChanged(a1_2) -- Line: 30
        -- upvalues: a1 (val), LocalPlayer (upval), Util (val), Window (val), u17 (val)
        local v1, v2
        local v3 = a1.Dispatcher:Evaluate(a1_2, LocalPlayer, true)
        local v4 = Util.SplitString(a1_2)
        local v5 = table.remove(v4, 1)
        local v6 = false
        if v3 then
            v4 = Util.MashExcessArguments(v4, #v3.Object.Args)
            v6 = #v4 == #v3.Object.Args
        end
        local v7 = v5 and #v4 > 0
        if (a1_2:sub(#a1_2, #a1_2)):match("%s") and not v6 then
            v7 = true
            v4[#v4 + 1] = ""
        end
        if v3 and v7 then
            v1, v2 = v3:Validate()
            Window:SetIsValidInput(v1, (("Validation errors: %s"):format(v2 or "")))
            v1 = {}
            local Argument = v3:GetArgument(#v4)
            if not Argument then
                Window:SetIsValidInput(false, "Use the help command to see all available commands.")
                u17:Hide()
                return
            end
            local TextSegmentInProgress = Argument.TextSegmentInProgress
            local v8 = false
            if not Argument.RawSegmentsAreAutocomplete then
                local Autocomplete, Autocomplete_2 = Argument:GetAutocomplete()
                v8 = (Autocomplete_2 or {}).IsPartial or false
                for k, v in pairs(Autocomplete) do
                    v1[k] = {TextSegmentInProgress, v}
                end
            else
                for i, i2 in ipairs(Argument.RawSegments) do
                    v1[i] = {i2, i2}
                end
            end
            local v9 = true
            if #TextSegmentInProgress > 0 then
                local v10, v11 = Argument:Validate()
                v9 = v10
                v2 = v11
            end
            if not v6 and v9 then
                Window:HideInvalidState()
            end
            local v12 = {}
            local v13 = v6
            if v13 then
                local v14 = #a1_2 - #TextSegmentInProgress
                v13 = v14 + (if not (a1_2:sub(#a1_2, #a1_2)):match("%s") then 0 else -1)
            end
            v12.at = v13
            v12.prefix = not (#Argument.RawSegments ~= 1) and Argument.Prefix or ""
            v13 = false
            if #v3.Arguments == #v3.ArgumentDefinitions then
                v13 = #TextSegmentInProgress > 0
            end
            v12.isLast = v13
            v12.numArgs = #v4
            v12.command = v3
            v12.arg = Argument
            local Name = Argument.Name
            v12.name = Name .. (if not Argument.Required then "?" else "")
            v12.type = Argument.Type.DisplayName
            v12.description = not (v9 ~= false) and v2 or Argument.Object.Description
            v12.invalid = not v9
            v12.isPartial = v8
            return u17:Show(v1, v12)
        end
        if v5 and #v4 == 0 then
            local Command_2
            Window:SetIsValidInput(true)
            local Command = a1.Registry:GetCommand(v5)
            v2 = nil
            if not Command then
                Window:SetIsValidInput(
                    false,
                    (("%q is not a valid command name. Use the help command to see all available commands."):format(v5))
                )
            else
                v2 = {
                    Command.Name,
                    Command.Name,
                    options = {name = Command.Name, description = Command.Description},
                }
                local Args = Command.Args and Command.Args[1]
                if type(Args) == "function" then
                    Args = Args(v3)
                end
                if Args and not Args.Optional and Args.Default == nil then
                    Window:SetIsValidInput(false, "This command has required arguments.")
                    Window:HideInvalidState()
                end
            end
            v1 = {v2}
            for k2, j in pairs(a1.Registry:GetCommandNames()) do
                if (v5:lower()) == (j:lower()):sub(1, #v5) then
                    if v2 == nil or v2[1] ~= v5 then
                        Command_2 = a1.Registry:GetCommand(j)
                        v1[#v1 + 1] = {
                            v5,
                            j,
                            options = {name = Command_2.Name, description = Command_2.Description},
                        }
                    end
                end
            end
            return u17:Show(v1)
        end
        Window:SetIsValidInput(false, "Use the help command to see all available commands.")
        u17:Hide()
    end

    Window:UpdateLabel()
    Window:UpdateWindowHeight()
    return {Window = Window, AutoComplete = u17}
end