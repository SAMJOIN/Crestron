<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="/apps/css/font-awesome.css">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/bootstrap.min.css">
    <link type="Image/x-icon" href="favicon.jpg" rel="icon">
    <title>Crestron</title>
    <script src="/apps/js/jquery.js.gz"></script>
    <script src="JS/bootstrap.min.js"></script>
    <script src="JS/scripts.js"></script>
    <link href="CSS/datatables.min.css" rel="stylesheet">
    <script src="JS/datatables.min.js"></script>
    <script src="JS/jquery.maskedinput.js"></script>
</head>

<body>
    <!-- Заголовок -->
    <header>
        <div style="display: inline-block;">
            <span class="button" data-bs-toggle="modal" data-bs-target="#formModal">
                <i class="fa fa-cog" aria-hidden="true"></i>
            </span>
        </div>
        <select class="type_selector" onchange="setLine(this.value)">
            <option value="Analogs">Analogs</option>
            <option value="Digitals">Digitals</option>
            <option value="Serials">Serials</option>
        </select>
        <h1 class="title">Crestron</h1>
        <div style="display: inline-block;">
            <span class="button">
                <a style="text-decoration: none; color: white;" href="/apps/">
                    <i class="fa fa-home" aria-hidden="true"></i>
                </a>
            </span>
        </div>
    </header>

    <!-- Модалка для настройки конфига -->

    <div class="modal fade" id="formModal" tabindex="-1" aria-hidden="true" aria-labelledby="formLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="formLabel">Configuration menu</h5>
                    <button class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                </div>
                <div class="modal-body">
                    <? require('apps')
        conf = storage.get('app:crestron:config', {})
        ?>
                    <div class="row align-items-center justify-content-center">
                        <div class="col-4">
                            <div class="mb-3">
                                <label for="ip-input" class="form-label">Ip</label>
                                <input type="text" class="form-control" id="ip-input" aria-describedby="emailHelp"
                                    value="<?=escape(conf.ip or '')?>">
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="mb-3">
                                <label for="port-input" class="form-label">Port</label>
                                <input type="text" class="form-control" id="port-input" maxlength="5"
                                    value="<?=escape(conf.port or '')?>">
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="mb-3">
                                <label for="ipid-input" class="form-label">Ipid</label>
                                <input type="text" class="form-control" id="ipid-input" maxlength="5"
                                    value="<?=escape(conf.ipid or '')?>">
                            </div>
                        </div>
                    </div>

                    <div class="row align-items-cenet justify-content-center">
                        <div class="col-4">
                            <div class="mb-3">
                                <label for="username-input" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username-input" maxlength="16"
                                    value="<?=escape(conf.username or '')?>">
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="mb-3">
                                <label for="password-input" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password-input" maxlength="16"
                                    value="<?=escape(conf.password or '')?>">
                            </div>
                        </div>

                        <!-- <div class="col-4">
                            <div class="mb-3">
                                <label for="ssl-input" class="form-label">Ssl</label>
                                <input type="text" class="form-control" id="ssl-input"
                                    value="<?=escape(conf.ssl or '')?>">
                            </div>
                        </div> -->
                    </div>

                    <div class="row align-items-cenet justify-content-center">
                        <div class="col-4">
                            <label class="form-label">Debug</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="radioDebug" id="debugInfo1"
                                    value="True" <?if conf.debug=='True' then print('checked') end?>>
                                <label class="form-check-label" for="debugInfo1">
                                    True
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="radioDebug" id="debugInfo2"
                                    value="False" <?if conf.debug=='False' then print('checked') end?>>
                                <label class="form-check-label" for="debugInfo2">
                                    False
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal" aria-label="close"
                        onclick="getInfo()">Save</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Модалка для редактирования и добавления новых записей -->

    <div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true" aria-labelledby="editLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editLabel">Configuration menu</h5>
                    <button class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                </div>
                <div class="modal-body">
                    <div class="row align-items-cenet justify-content-center">
                        <div class="col-4">
                            <div class="mb-3">
                                <label for="From-input" class="form-label">From:</label>
                                <input type="text" maxlength="9" class="form-control" id="From-input">
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="mb-3">
                                <label for="To-input" class="form-label">To:</label>
                                <input type="text" maxlength="9" class="form-control" id="To-input">
                            </div>
                        </div>
                    </div>
                </div>
                <input type="text" id="Table-type" style="display: none;">
                <div class="modal-footer">
                    <button class="btn btn-secondary" onclick="saveEdit()" data-bs-dismiss="modal"
                        aria-label="close">Save</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Таблицы -->

    <div class="content">

        <!-- Таблица "Analogs" -->

        <div id="analogs" class="analogs">
            <table id="analogs-table">
                <thead>
                    <tr>
                        <th>from</th>
                        <th>to</th>
                        <th class="update-btn"><span class="button" data-bs-toggle="modal" data-bs-target="#editModal"
                                onclick="openEdit('', '', 'analogs', false) ">
                                <i class="fa fa-plus-square" aria-hidden="true"></i>
                            </span></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <? analogs = storage.get('app:crestron:analogs',{})
            for from, to in pairs(analogs) do
                ?>
                    <tr>
                        <td>
                            <?=from?>
                        </td>
                        <td>
                            <?=to?>
                        </td>
                        <td class="update-btn"><span class="button" data-bs-toggle="modal" data-bs-target="#editModal"
                                onclick="openEdit('<?=from?>','<?=to?>', 'analogs',true, this)">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </span></td>
                        <!-- TODO: Сделать функцию удаления записи -->
                        <td class="update-btn"><span class="button"
                                onclick="deleteLine('<?=from?>','<?=to?>', 'analogs', this)"
                                style="margin-left: -90px;">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </span></td>
                    </tr>
                    <?
            end
            ?>
                </tbody>
            </table>
        </div>

        <!-- Таблица "Digitals" -->

        <div id="digitals" class="digitals">
            <table id="digitals-table">
                <thead>
                    <tr>
                        <th>from</th>
                        <th>to</th>
                        <th class="update-btn"><span class="button" data-bs-toggle="modal" data-bs-target="#editModal"
                                onclick="openEdit('', '', 'digitals', false)">
                                <i class="fa fa-plus-square" aria-hidden="true"></i>
                            </span></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <? digitals = storage.get('app:crestron:digitals',{})
            for from, to in pairs(digitals) do
                ?>
                    <tr>
                        <td>
                            <?=from?>
                        </td>
                        <td>
                            <?=to?>
                        </td>
                        <td class="update-btn"><span class="button" data-bs-toggle="modal" data-bs-target="#editModal"
                                onclick="openEdit('<?=from?>','<?=to?>', 'digitals' ,true)">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </span></td>
                        <td class="update-btn"><span class="button"
                                onclick="deleteLine('<?=from?>','<?=to?>', 'digitals', this)"
                                style="margin-left: -90px;">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </span></td>
                    </tr>
                    <?
            end
            ?>
                </tbody>
            </table>
        </div>

        <!-- Таблица "Serials" -->

        <div id="serials" class="serials">
            <table id="serials-table">
                <thead>
                    <tr>
                        <th>from</th>
                        <th>to</th>
                        <th class="update-btn"><span class="button" data-bs-toggle="modal" data-bs-target="#editModal"
                                onclick="openEdit('', '', 'serials', false)">
                                <i class="fa fa-plus-square" aria-hidden="true"></i>
                            </span></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <? serials = storage.get('app:crestron:serials',{})
            for from, to in pairs(serials) do
                ?>
                    <tr>
                        <td>
                            <?=from?>
                        </td>
                        <td>
                            <?=to?>
                        </td>
                        <td class="update-btn"><span class="button" data-bs-toggle="modal" data-bs-target="#editModal"
                                onclick="openEdit('<?=from?>','<?=to?>', 'serials',true)">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </span></td>
                        <td class="update-btn"><span class="button"
                                onclick="deleteLine('<?=from?>','<?=to?>', 'serials', this)"
                                style="margin-left: -90px;">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </span></td>
                    </tr>
                    <?
            end
            ?>
                </tbody>
            </table>
        </div>
    </div>

    <script>

        new DataTable('table', {
            order: [[0, 'asc']],
            columnDefs: [
                { orderable: false, targets: 2 },
                { orderable: false, targets: 3 }
            ],
            info: false,
            lengthChange: false,
        });

        $("#ip-input").mask('999.999.999.999');
        $('#username-input').keypress(function (e) {
            // только такие символы
            var regx = /^[a-zA-Zа-яА-ЯёЁ\d.,;:&()*%#\s-]$/;
            if (!e.key.match(regx))
                e.preventDefault();
        });
        $('#port-input').keypress(function (e) {
            // только такие символы
            var regx = /^[0-9]$/;
            if (!e.key.match(regx))
                e.preventDefault();
        });
        $('#ipid-input').keypress(function (e) {
            // только такие символы
            var regx = /^[0-9]$/;
            if (!e.key.match(regx))
                e.preventDefault();
        });
        $('#password-input').keypress(function (e) {
            // только такие символы
            var regx = /^[a-zA-Zа-яА-ЯёЁ\d.,;:&()*%#\s-]$/;
            if (!e.key.match(regx))
                e.preventDefault();
        });
        $('#From-input').keypress(function (e) {
            // только такие символы
            var regx = /^[0-9+\/]$/;
            let value = $(this).val();
            if (!e.key.match(regx))
                e.preventDefault();
            if (value.includes('/'))
                $('#To-input').mask('9?9999');
            else
                $('#To-input').mask('99/9/999');
        });
        $('#To-input').keypress(function (e) {
            // только такие символы
            var regx = /^[0-9+\/]$/;
            if (!e.key.match(regx))
                e.preventDefault();
        });

    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</body>

</html>