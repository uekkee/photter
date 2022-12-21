module.exports = {
    "env": {
        "browser": true,
        "es2021": true,
        "node": true,
        "jest": true
    },
    "extends": "eslint:recommended",
    "parser": "babel-eslint",
    "parserOptions": {
        "ecmaVersion": 12,
        "sourceType": "module"
    },
    "plugins": ['jest'],
    "rules": {
        "no-console": "error"
    },
    "settings": {
        'import/resolver': {
            "webpack": {
                "config": './config/webpack/development.js'
            }
        }
    }
};
