import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.0

ApplicationWindow {
    id: app
    visible: true
    visibility: "Windowed"
    width: Screen.width
    height: txt.contentHeight*1.2
    property int fs: width*0.02
    flags: Qt.FramelessWindowHint
    color: 'white'
    y:Screen.height-height+app.fs*2
    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            id: r1
            anchors.fill: parent
            color: 'green'
            SequentialAnimation on color {
                id: seq1
                running: false
                loops: Animation.Infinite
                PropertyAnimation { to: "black"; duration: 1 }
                PauseAnimation {
                    duration: 1500
                }
                PropertyAnimation { to: "white"; duration: 1 }
                PauseAnimation {
                    duration: 1500
                }
            }
        }

        Text {
            id: txt
            text: 'Mensaje'
            font.pixelSize: app.fs
            color: 'red'
            anchors.centerIn: parent
            SequentialAnimation on color {
                id: seq2
                running: false
                loops: Animation.Infinite
                PropertyAnimation { to: "white"; duration: 1 }
                PauseAnimation {
                    duration: 1500
                }
                PropertyAnimation { to: "black"; duration: 1 }
                PauseAnimation {
                    duration: 1500
                }
            }
        }
        /*Timer{
            id: timerColor
            running: true
            repeat: true
            interval: 1000
            onTriggered: {
                //txt.color=txt.color==='red'?'white':'red'
                app.color=app.color==="#000000"?"#ffffff":"#000000"
            }
        }*/
        Timer{
            id: timerMsg
            running: false
            repeat: false
            interval: 1000
            property var am: []
            property var ad: []
            property var af: []
            property int currentIndex: 0
            onTriggered: {
                stop()
                interval=ad[currentIndex]*1000
                txt.text=am[currentIndex]
                txt.font.pixelSize=af[currentIndex]*app.fs
                if(currentIndex<am.length-1){
                    currentIndex++
                }else{
                    currentIndex=0
                }
                start()
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Component.onCompleted: {
        let j='{
            "msg0":{"msg": "Si estas en el chat y no te contesto prueba enviando un whatsapp con el comando !wsp", "dur": 3, "fs":1.2},
            "msg1":{"msg": "Si envias tu fecha, hora y ciudad de nacimiento por Whatsapp leemos tu Carta Natal !wsp", "dur": 30, "fs":1}
        }'
        let json=JSON.parse(j)
        for(var i=0;i<Object.keys(json).length;i++){
            timerMsg.am.push(json['msg'+i].msg)
            timerMsg.ad.push(json['msg'+i].dur)
            timerMsg.af.push(json['msg'+i].fs)
        }
        timerMsg.start()
        seq1.start()
        seq2.start()
        //console.log('M0:'+json.msg0.msg)
    }
}
