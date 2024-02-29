--ui.lua

local ui = {

	line = function()
		ImGui.Spacing()
		ImGui.Separator()
		ImGui.Spacing()
	end,

	space = function()
        ImGui.Spacing()
	end,

	text = function( text )
		ImGui.Text( text)
	end,

	section = function( text )
		ImGui.Spacing()
		ImGui.Separator()
		ImGui.TextWrapped( text )
		ImGui.Spacing()
	end,

	heading = function( text )
		ImGui.Spacing()
		ImGui.Text( "Skin/Hair" )
		ImGui.Spacing()
	end,

	tooltip = function( text )
		if ImGui.IsItemHovered() and text ~= "" then
			ImGui.BeginTooltip()
			ImGui.SetTooltip( text )
			ImGui.EndTooltip()
		end
	end,
}

return ui