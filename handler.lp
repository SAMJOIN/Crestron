<?
-- /handler.lp?ip=ip&ipid=ipid
require('apps')
require('json')
vars = getvars()
vprint(vars)
if vars.ip and vars.ipid and vars.port then
    conf = {}
    conf.ip = vars.ip
    conf.port = vars.port
    conf.ipid = vars.ipid
    conf.username = vars.username or ''
    conf.password = vars.password or ''
    conf.ssl = vars.ssl or ''
    conf.debug = vars.debug or false
    storage.set('app:crestron:config', conf)
end
if vars.fn == 'get_config' then
    conf = storage.get('app:crestron:config')
    if conf then print(json.encode(conf)) end
end

if vars.from and vars.to and vars.type then
    if vars.type == 'analogs' then
        from = tostring(vars.from)
        to = tostring(vars.to)
        analogs = storage.get('app:crestron:analogs', {})
        analogs[from] = to
        storage.set('app:crestron:analogs', analogs)
    end

    if vars.type == 'digitals' then
        from = tostring(vars.from)
        to = tostring(vars.to)
        digitals = storage.get('app:crestron:digitals', {})
        digitals[from] = to
        storage.set('app:crestron:digitals', digitals)
    end

    if vars.type == 'serials' then
        from = tostring(vars.from)
        to = tostring(vars.to)
        serials = storage.get('app:crestron:serials', {})
        serials[from] = to
        storage.set('app:crestron:serials', serials)
    end
end

-- Удаление записи по крестику
if vars.from and vars.to and vars.type and vars.delete then
    if vars.type == 'analogs' then
        from = tostring(vars.from)
        to = tostring(vars.to)
        analogs = storage.get('app:crestron:analogs', {})
        analogs[from] = nil
        storage.set('app:crestron:analogs', analogs)
    end

    if vars.type == 'digitals' then
        from = tostring(vars.from)
        to = tostring(vars.to)
        digitals = storage.get('app:crestron:digitals', {})
        digitals[from] = nil
        storage.set('app:crestron:digitals', digitals)
    end

    if vars.type == 'serials' then
        from = tostring(vars.from)
        to = tostring(vars.to)
        serials = storage.get('app:crestron:serials', {})
        serials[from] = nil
        storage.set('app:crestron:serials', serials)
    end
end

?>
