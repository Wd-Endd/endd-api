# Endd-API? 
Endd-API is an npm library that I created just for the convenience of my daily Coding ;-;
# What about it?
- Copy Supper Sync: At first it will take longer than fs's Copy system, but the 2nd, 3rd, 4th,... times will be extremely fast because I have used the system to read, compare Mtime
and then Copy.
- LiveServer (Beta): Used to host a directory that you specify (as long as it has index.html inside) onto a localhost page, making it easy for you to coding a website.
# Howto Use
- install & setup: 
Put the ``endd-api.sh`` file into your workspace (``node_modules/../``)
Run this file, can be run by entering terminal command:
```sh
wget https://raw.githubusercontent.com/Wd-Endd/endd-api/main/endd-api-installer.sh
bash endd-api.sh
```
- Apply to your code:
You need to add the following methods to your code
```JavaScript
const { copySupperSync, liveServer } = require("endd-api");

copySupperSync(
  "source/directory_or_file",
  "destination/directory_or_file",
  ["source/except1", "source/except2"] // Or not;-;
);
liveServer("target/directory", 5500 /*Port*/ );
```

;-;