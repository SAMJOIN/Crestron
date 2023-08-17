


function setLine(value) {
    if (value === 'Analogs') {
        showAnalog();
    }
    else if (value === 'Digitals') {
        showDigital();
    }
    else {
        showSerial();
    }
}

function getInfo() {
    let ip_info = document.getElementById("ip-input").value;
    let port_info = document.getElementById("port-input").value;
    let ipid_info = document.getElementById("ipid-input").value;
    let username_info = document.getElementById("username-input").value;
    let psw_info = document.getElementById("password-input").value;
    // let ssl_info = document.getElementById("ssl-input").value;
    let debug_info = document.querySelector('input[name="radioDebug"]:checked').value;
    let config = {
        ip: ip_info,
        port: port_info,
        ipid: ipid_info,
        username: username_info,
        password: psw_info,
        // ssl: ssl_info,
        debug: debug_info
    }

    let json = JSON.stringify(config);
    $.post("handler.lp", config, (data, status) => {
        console.log(data);
    });
}

function showAnalog() {
    closeTable();
    document.getElementById('analogs').style.visibility = 'visible';
}
function showDigital() {
    closeTable();
    document.getElementById('digitals').style.visibility = 'visible';
}
function showSerial() {
    closeTable();
    document.getElementById('serials').style.visibility = 'visible';
}

function closeTable() {
    document.getElementById('analogs').style.visibility = 'hidden';
    document.getElementById('digitals').style.visibility = 'hidden';
    document.getElementById('serials').style.visibility = 'hidden';
}

function saveEdit() {

    let from = document.getElementById('From-input').value;
    let to = document.getElementById('To-input').value;
    let type = document.getElementById('Table-type').value;
    let table;
    if (type === 'analogs') {
        table = document.getElementById('analogs-table');
    }
    else if (type === 'digitals') {
        table = document.getElementById('digitals-table');
    }
    else {
        table = document.getElementById('serials-table');
    }


    if (document.getElementById('From-input').disabled == false) {
        let tr = document.createElement('tr');
        tr.innerHTML = '<td>' + from + '</td><td>' + to + '</td>'
        table.appendChild(tr);
    } 

    let package = {
        from: from,
        to: to,
        type: type
    }
    $.post("handler.lp", package, (data, status) => {
        console.log(data);
    });
}

function openEdit(from, to, type, from_block) {
    if (from.includes('/'))
        $('#To-input').mask('9?9999');
    else
        $('#To-input').mask('99/9/999');

    if (from_block)
        document.getElementById('From-input').disabled = true;
    else
        document.getElementById('From-input').disabled = false;

    document.getElementById('From-input').value = from;
    document.getElementById('To-input').value = to;
    document.getElementById('Table-type').value = type;
}

let deleteLine = (from, to, type, parent) => {

    let table;
    if (type === 'analogs') {
        table = document.getElementById('analogs-table');
    }
    else if (type === 'digitals') {
        table = document.getElementById('digitals-table');
    }
    else {
        table = document.getElementById('serials-table');
    }

    parent.closest('tr').remove();

    let package = {
        from,
        to,
        type,
        delete: true
    }
    $.post("handler.lp", package, (data, status) => {
        console.log(data);
    });
}




