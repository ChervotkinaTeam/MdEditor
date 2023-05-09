# MdEditor

**MdEditor** - это простой текстовый редактор с поддержкой язык разметки Markdown.

[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

В проекте используются следующие шаблоны проектирования:
- DI
- CleanSwift

Для верстки экранов используется: 
- PinLayout

## Getting Started

- Установите менеджер недостающих пакетов для macOS Homebrew с помощью команды в терминале 
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Скачайте и установите Tuist - is a command line tool (CLI) that aims to facilitate the generation, maintenance, and interaction with Xcode projects.
```
curl -Ls https://install.tuist.io | bash
```


- Клонируйте репозиторий
```
cd ~/Developer
git clone https://github.com/ChervotkinaTeam/MdEditor.git
cd ./MdEditor
tuist fetch
tuist generate
```

- Cгенерируйте фалы проекта Xcode
```
tuist fetch
tuist generate
```

## Features


## Требования

- Написано на Swift 5;
- Поддерживается версия iOS 14;
- Необходим Xcode 14+;
- Tuist;
