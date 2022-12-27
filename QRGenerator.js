const QRCode = require('qrcode');

const generateQR = async text => {
    try {
        await QRCode.toFile('./PATH/NAME.png', text);
    } catch (err) {
        console.log(err);
    }
}

generateQR("#");
