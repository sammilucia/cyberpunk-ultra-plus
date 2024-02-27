local Draw = {

    Line = function()

        ImGui.Spacing()
        ImGui.Separator()
        ImGui.Spacing()

    end,

    Section = function( text )

        ImGui.Spacing()
        ImGui.Separator()
        ImGui.PushStyleColor( ImGuiCol.Text, 0xff888888 )
        ImGui.TextWrapped( text )
        ImGui.PopStyleColor()
        ImGui.Spacing()

    end,

    Heading = function( text )

        ImGui.Spacing()
        ImGui.Text( "Skin/Hair" )
        ImGui.Spacing()

    end,

    Tooltip = function( text )

        if ImGui.IsItemHovered() and text ~= "" then

            ImGui.BeginTooltip()
            ImGui.SetTooltip( text )
            ImGui.EndTooltip()

        end
    end,
}

return Draw