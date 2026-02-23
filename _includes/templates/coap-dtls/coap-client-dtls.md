按以下步骤在Linux上安装支持DTLS的CoAP客户端：

- 步骤 1：克隆libcoap的git仓库：

```bash
git clone https://github.com/obgm/libcoap --recursive --depth 1
```
{: .copy-code}

- 步骤 2：进入libcoap目录：

```bash
cd libcoap
```
{: .copy-code}

- 步骤 3：执行以下命令，然后运行 ./autogen.sh 脚本：

```bash
sudo apt-get update
```
{: .copy-code}


```bash
sudo apt-get install autoconf libtool libssl-dev
```
{: .copy-code}


```bash
./autogen.sh
```
{: .copy-code}

- 步骤 4：使用以下选项运行 ./configure 脚本：

```bash
./configure --with-openssl --disable-doxygen --disable-manpages --disable-shared
```
{: .copy-code}

- 步骤 5：执行以下命令：

```bash
make
```
{: .copy-code}

- 步骤 6：执行以下命令：

```bash
sudo make install
```
{: .copy-code}
