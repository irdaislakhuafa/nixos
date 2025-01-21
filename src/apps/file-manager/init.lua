function Linemode:permissions_and_size_and_mtime()
	local year = os.date("%Y")
	local time = (self._file.cha.modified or 0) // 1

	if time > 0 and os.date("%Y", time) == year then
		time = os.date("%b %d %H:%M", time)
	else
		time = time and os.date("%b %d  %Y", time) or ""
	end

	local size = self._file:size()
	local permissions = self._file:permissions() -- Ambil izin file
	local readable_size = size and ya.readable_size(size) or "-"

	return ui.Line(string.format(" %s %s %s ", permissions or "-", readable_size, time))
end
