/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.11
import QtQuick.Controls 2.4
import QtQuick.Dialogs  1.3
import QtQuick.Layouts  1.11

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0

Item {
    anchors.fill: parent
    readonly property real _indicatorMargins: ScreenTools.defaultFontPixelHeight * 0.75
    //-------------------------------------------------------------------------
    //-- Waiting for a vehicle
    Row {
        id:                         waitForVehicle
        spacing:                    ScreenTools.defaultFontPixelWidth
        visible:                    !activeVehicle
        anchors.top:                parent.top
        anchors.bottom:             parent.bottom
        anchors.left:               parent.left
        QGCColoredImage {
            id:                     menuEdge
            anchors.verticalCenter: parent.verticalCenter
            height:                 ScreenTools.defaultFontPixelHeight
            width:                  height
            sourceSize.height:      parent.height
            fillMode:               Image.PreserveAspectFit
            source:                 "/auterion/img/vehicle.svg"
            color:                  qgcPal.buttonText
        }
        QGCLabel {
            anchors.verticalCenter: parent.verticalCenter
            text:                   qsTr("Waiting for a vehicle")
            font.pointSize:         ScreenTools.mediumFontPointSize
            font.family:            ScreenTools.demiboldFontFamily
        }
    }
    //-------------------------------------------------------------------------
    //-- Toolbar Indicators
    Row {
        id:                         indicatorRow
        anchors.top:                parent.top
        anchors.bottom:             parent.bottom
        anchors.right:              parent.right
        anchors.rightMargin:        ScreenTools.defaultFontPixelWidth * 2
        spacing:                    ScreenTools.defaultFontPixelWidth * 2
        visible:                    activeVehicle && !communicationLost
        Repeater {
            model:                  activeVehicle ? activeVehicle.toolBarIndicators : []
            Loader {
                anchors.top:        parent.top
                anchors.bottom:     parent.bottom
                anchors.margins:    _indicatorMargins
                source:             modelData;
            }
        }
        Item {
            width:                  1
            height:                 1
        }
        Loader {
            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.margins:        _indicatorMargins
            source:                 "/auterion/AuterionMessageIndicator.qml"
        }
    }
}
