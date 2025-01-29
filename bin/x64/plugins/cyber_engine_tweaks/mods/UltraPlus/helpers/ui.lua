-- helpers/ui.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
local theme = require('helpers/theme')
local ui = {}

ui.separator = function()
	ImGui.Spacing()
	ImGui.Separator()
	ImGui.Spacing()
end

ui.space = function()
	ImGui.Spacing()
end

ui.cursor = function(x, y)
	-- account for window borders
	if x then
		ImGui.SetCursorPosX((x + 8) * Var.window.scale)
	end
	if y then
		ImGui.SetCursorPosY((y * Var.window.scale) + Var.window.startY)
	end
end

ui.width = function(px)
	if not px then
		return
	end
	ImGui.SetNextItemWidth(px * Var.window.scale)
end

ui.sameLine = function(px)
	if px then
		ImGui.SameLine(px * Var.window.scale)
	else
		ImGui.SameLine()
	end
end

ui.text = function(...)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.Text(...)
	ImGui.PopStyleColor()
end

ui.window = function(title, flags, func)
	ImGui.PushStyleColor(ImGuiCol.WindowBg, theme.color.bg)
	ImGui.PushStyleColor(ImGuiCol.ChildBg, theme.color.bg)
	ImGui.PushStyleColor(ImGuiCol.Border, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.TitleBg, theme.color.bg)
	ImGui.PushStyleColor(ImGuiCol.TitleBgActive, theme.color.bg)
	ImGui.PushStyleColor(ImGuiCol.TitleBgCollapsed, theme.color.bg)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarBg, theme.color.bg)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrab, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabHovered, theme.color.mediumer)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabActive, theme.color.mediumer)

	ImGui.SetNextWindowPos(10, 500, ImGuiCond.FirstUseEver)
	ImGui.SetNextWindowSize(430 * Var.window.scale, 518 * Var.window.scale)

	if ImGui.Begin(title, true, flags) then
		ImGui.SetWindowFontScale(theme.textScale)

		func()

		local screenWidth = select(1, GetDisplayResolution())
		if screenWidth > 1000 then
			if screenWidth > 3800 then
				Var.window.scale = (screenWidth / 1880) * theme.textScale
			elseif screenWidth > 3000 then
				Var.window.scale = (screenWidth / 1932) * theme.textScale
			elseif screenWidth > 2000 then
				Var.window.scale = (screenWidth / 1880) * theme.textScale
			else
				Var.window.scale = (screenWidth / 1900) * theme.textScale
			end
		end

		ImGui.End()
	end

	ImGui.PopStyleColor(10)
end

ui.tab = function(label, func)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.PushStyleColor(ImGuiCol.Tab, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.TabHovered, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.TabActive, theme.color.medium)

	local isOpen = ImGui.BeginTabItem(label)
	ImGui.PopStyleColor(4)

	if isOpen then
		func()
		ImGui.EndTabItem()
	end
end

ui.tabBar = function(func)
	ImGui.PushStyleColor(ImGuiCol.TabActive, theme.color.dark)

	if ImGui.BeginTabBar('Tabs') then
		func()
		ImGui.EndTabBar()
	end

	ImGui.PopStyleColor()
end

ui.button = function(label)
	ImGui.PushStyleColor(ImGuiCol.Button, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, theme.color.dark)
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, theme.color.medium)

	local result = ImGui.Button(label)

	ImGui.PopStyleColor(3)
	return result
end

ui.filter = function(label, text, textBufferSize)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.PushStyleColor(ImGuiCol.FrameBg, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, theme.color.dark)
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.Button, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, theme.color.dark)
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.TextSelectedBg, theme.color.medium)

	local newBuffer = ImGui.InputText(label, text, textBufferSize)

	ImGui.SameLine()
	if ImGui.Button('Clear') then
		newBuffer = ''
	end

	ImGui.PopStyleColor(8)
	return newBuffer
end

ui.inputInt = function(label, ...)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.PushStyleColor(ImGuiCol.FrameBg, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.Button, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.TextSelectedBg, theme.color.medium)

	local result, changed = ImGui.InputInt(label, ...)

	ImGui.PopStyleColor(8)
	return result, changed
end

ui.inputFloat = function(label, value)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.PushStyleColor(ImGuiCol.FrameBg, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, theme.color.medium)
	ImGui.PushStyleColor(ImGuiCol.TextSelectedBg, theme.color.medium)

	local result, changed = ImGui.InputFloat(label, value)

	ImGui.PopStyleColor(5)
	return result, changed
end

ui.header = function(text)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.PushStyleColor(ImGuiCol.Header, theme.color.dark)
	ImGui.PushStyleColor(ImGuiCol.HeaderHovered, theme.color.dark)
	ImGui.PushStyleColor(ImGuiCol.HeaderActive, theme.color.dark)

	local result = ImGui.CollapsingHeader(text, ImGuiTreeNodeFlags.DefaultOpen)

	ImGui.PopStyleColor(4)
	return result
end

ui.radio = function(label, isActive)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.PushStyleColor(ImGuiCol.FrameBg, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.CheckMark, theme.color.light)
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, theme.color.medium)

	local result = ImGui.RadioButton(label, isActive)

	ImGui.PopStyleColor(4)
	return result
end

ui.checkbox = function(label, value)
	ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
	ImGui.PushStyleColor(ImGuiCol.FrameBg, theme.color.darker)
	ImGui.PushStyleColor(ImGuiCol.CheckMark, theme.color.light)
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, theme.color.medium)

	local result, toggled = ImGui.Checkbox(label, value)

	ImGui.PopStyleColor(4)
	return result, toggled
end

ui.tooltip = function(text)
	if ImGui.IsItemHovered() and text ~= '' then
		ImGui.PushStyleColor(ImGuiCol.Text, theme.color.text)
		ImGui.BeginTooltip()
		ImGui.SetTooltip(text)
		ImGui.EndTooltip()
		ImGui.PopStyleColor()
	end
end

return ui
