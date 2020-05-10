# webmethods-devops-starter
starter project with ansible, cce, and build files

## setup

```
git submodule add https://github.com/lanimall/webmethods-devops-cce.git common/webmethods-cce
git submodule add https://github.com/lanimall/webmethods-devops-ansible.git common/webmethods-ansible
git submodule update --init --recursive
```

## build

```
./build.sh
```