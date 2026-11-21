# Reference Tooling Configurations

Use these reference configurations when creating or updating the formatting and linting tooling.

## C# — `.editorconfig` (repository root)

```editorconfig
root = true

[*]
charset = utf-8
end_of_line = lf
indent_style = space
indent_size = 4
max_line_length = 120
trim_trailing_whitespace = false
insert_final_newline = false

[*.cs]
csharp_style_var_for_built_in_types = false:suggestion
csharp_style_var_when_type_is_apparent = true:suggestion
csharp_style_var_elsewhere = false:suggestion

[*.yml]
indent_size = 2
```

## CDK — `cicd/.eslintrc.json`

```json
{
    "env": {
        "es2021": true,
        "node": true
    },
    "parser": "@typescript-eslint/parser",
    "plugins": ["@typescript-eslint"],
    "extends": ["eslint:recommended", "plugin:@typescript-eslint/recommended", "prettier"],
    "parserOptions": {
        "ecmaVersion": 2021,
        "sourceType": "module"
    }
}
```

## CDK — `cicd/.prettierrc.json`

```json
{
    "semi": false,
    "singleQuote": true,
    "quoteProps": "consistent",
    "trailingComma": "es5",
    "arrowParens": "always",
    "bracketSpacing": true
}
```

## CDK — `cicd/.prettierignore`

```
dist/
cdk.out/
```

## CDK — `cicd/package.json` scripts

Ensure the `scripts` section includes:

```json
{
    "format:write": "prettier --write .",
    "format:check": "prettier --check .",
    "lint": "eslint './**/*.ts' --max-warnings=0"
}
```

Required devDependencies:
- `eslint`
- `@typescript-eslint/eslint-plugin`
- `@typescript-eslint/parser`
- `eslint-config-prettier`
- `prettier`

## Shell Scripts — `cicd/scripts/check-format.sh`

```bash
#!/bin/bash
rootDir=$(pwd)
set -e # Exit immediately if a pipeline returns a non-zero status
set -x # Print a trace of simple commands

cd $rootDir
dotnet format --verify-no-changes --exclude '**/Migrations/**'

cd $rootDir/cicd
npm run format:check
npm run lint
```

## Shell Scripts — `cicd/scripts/format-code.sh`

```bash
#!/bin/bash
rootDir=$(pwd)
set -e # Exit immediately if a pipeline returns a non-zero status
set -x # Print a trace of simple commands

cd $rootDir
dotnet format --exclude '**/Migrations/**'

cd $rootDir/cicd
npm run format:write
npm run lint
```
