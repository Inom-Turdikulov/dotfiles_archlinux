local HISTFILE = (os.getenv('APPDATA') or os.getenv('HOME')..'/.config')..'/mpv/history.log';

mp.register_event('file-loaded', function()
    local title, fp;

    title = mp.get_property('media-title');
    title = (title == mp.get_property('filename') and '' or (' (%s)'):format(title));
    -- title = ''; -- uncomment here
    --
    fp = io.open(HISTFILE, 'a+');
    fp:write(('[%s] %s%s\n'):format(os.date('%Y-%m-%d %X'), mp.get_property('path'), title));
    fp:close();
end);

mp.register_event('idle', function()
    local fp, last;
    local pos;

    fp = io.open(HISTFILE, 'r');
    last = '';

    if not fp then
        return
    end

    fp:seek('end', -200);

    for line in fp:lines() do
        last = line;
    end;

    fp:close();

    pos = last:find(']');
    last = last:sub(pos + 2);

    mp.commandv('loadfile', last);
end);
