const pathSep = require('path').sep; //通过node.js path模块获取路径分割符
function createCustomModuleIdFactory() {
    const projectRootPath = __dirname; //node.js内置变量，获取项目路径，为了后面去掉路径前缀
    return (path) => {
        let customName = '';
        if (path.indexOf(projectRootPath) == 0) {
            //去掉路径前缀，因为里面带了当前打包机器的信息，不能保证唯一
            customName = path.substr(projectRootPath.length+1);
        }
        //将所有正斜杠换成 _ (考虑分隔符有\\和/的情况)
        let regExp = (pathSep == '\\') ? new RegExp('\\\\', 'gm') : new RegExp(pathSep, 'gm');
        customName = customName.replace(regExp, '_');
        return customName;
    }
}

function processCustomModuleFilter(module) {
    //业务bundle过滤node_modules下模块
    if(module['path'].indexOf(pathSep + 'node_modules' + pathSep) > 0){
        return false;
    }
    console.log('chenzhe:   ' + module['path']);
    return true;
}

module.exports = {
    serializer: {
        createModuleIdFactory: createCustomModuleIdFactory,
        processModuleFilter: processCustomModuleFilter
    }
}