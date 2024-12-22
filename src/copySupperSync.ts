import fs from "fs-extra";
import path from "path";

const green = "\x1b[32m";
const blue = "\x1b[34m";
const yellowOrange = "\x1b[33m";
const reset = "\x1b[0m";

/**
 * @param target - Source file/directory path
 * @param to - Destination directory path
 * @param except - Array containing source file/directory path strings that you want to exclude 
 */
export function copySupperSync(target: string, to: string, except: string[] = []) {

  // get mtime
  const mtimePath = path.resolve(to, ".mtime.json");
  let oldMtime = {};
  if (fs.existsSync(mtimePath)) {
    oldMtime = JSON.parse(fs.readFileSync(mtimePath, 'utf8'));
  }
  const newMtime = {};

  // function used to execute multiple times 
  /**
   * @param currentMtime - New mtime created
   * @param oldMtime - Mtime in .mtime.json file of destination path
   */
  function again(target: string, to: string, except: string[], currentMtime: any, oldMtime: any = {}) {

    // Execute complete and stop if source path to file
    if (fs.statSync(target).isFile()) {
      complete(target, to, oldMtime, currentMtime, path.basename(target), fs.statSync(target));
      return;
    }

    // Read directory
    const folder = fs.readdirSync(target);
    folder.forEach(file => {

      const sourcePath = path.resolve(target, file);
      const destinationPath = path.resolve(to, file);

      // Get file/directory status 
      const stats = fs.statSync(sourcePath);


      // Inform console.log and stop if file name is in exclusion
      if (except.some(excluded => sourcePath.includes(excluded))) {
        console.log(`${blue}Skipped${reset} ${sourcePath} ${yellowOrange}(excluded)${reset}`);
        return;
      }
  
      // Call again if state is directory 
      if (stats.isDirectory()) {
        fs.ensureDirSync(destinationPath);
        currentMtime[file] = {};
        again(sourcePath, destinationPath, except, currentMtime[file], oldMtime[file] || {});
      }

      // Otherwise, if it is a file, execute complete 
      else if (stats.isFile()) {
        complete(sourcePath, destinationPath, currentMtime, oldMtime, file, stats);
      }

    });
  }

  // Call again
  again(target, to, except, newMtime, oldMtime);

  // when all is done, create a new .mtime.json file in the destination
  fs.writeFileSync(mtimePath, JSON.stringify(newMtime, null, 2));
}

// Copy
function complete(
  sourcePath: string,
  destinationPath: string,
  oldMtime: Record<string, any>,
  currentMtime: Record<string, any>,
  file: string,
  stats: Record<string, any>
) {
  if (oldMtime[file] === JSON.parse(JSON.stringify(stats.mtime))) {
    console.log(`${blue}Skipped${reset} ${sourcePath} ${yellowOrange}(no changes)${reset}`);
  } else {
    fs.copySync(sourcePath, destinationPath);
    console.log(`${green}Copied${reset} ${sourcePath} ${blue}->${reset} ${destinationPath}`);
  }
  currentMtime[file] = stats.mtime;
}