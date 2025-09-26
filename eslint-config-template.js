// Template di configurazione ESLint per progetti con alias TypeScript
// Copia questo file nel tuo progetto come .eslintrc.js

module.exports = {
  extends: [
    "expo", // o "react", "react-native", ecc.
  ],
  parser: "@typescript-eslint/parser",
  plugins: ["@typescript-eslint", "import"],
  rules: {
    "react-hooks/exhaustive-deps": "off",
    // Disabilita errori per import non risolti se usi alias
    "import/no-unresolved": "off",
    // Abilita regole TypeScript
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "warn",
  },
  settings: {
    "import/resolver": {
      typescript: {
        // Questo risolve gli alias dal tsconfig.json
        alwaysTryTypes: true,
        project: "./tsconfig.json",
      },
      // Alternativa con path mapping esplicito
      alias: {
        map: [
          ["@", "./src"],
          ["@components", "./src/components"],
          ["@utils", "./src/utils"],
          ["@hooks", "./src/hooks"],
          ["@screens", "./src/screens"],
        ],
        extensions: [".ts", ".tsx", ".js", ".jsx"],
      },
    },
  },
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  parserOptions: {
    ecmaVersion: "latest",
    sourceType: "module",
    ecmaFeatures: {
      jsx: true,
    },
  },
};
