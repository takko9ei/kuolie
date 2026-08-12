# kuolie — 扩列图 LaTeX 模板

一个简洁的中文扩列图（自我介绍卡片） LaTeX 模板。版面结构参考了一些网上比较常见的扩列条，字体配色来自[Awesome-CV](https://github.com/posquit0/Awesome-CV) 。

`content/` 下只有数据，换风格在.tex内。

| `cardstyle=flat, divider=rule, accent=skyblue` | `cardstyle=soft, divider=hearts, accent=sakura` |
| :--: | :--: |
| ![极简预览](docs/preview-flat.png) | ![淡色卡预览](docs/preview-soft.png) |

上面两张图用的是**同一份** `content/`，区别是 `\kuoliesetup` 里的几个键。

---

## 快速开始

### 本地

需要 XeLaTeX（TeX Live / MacTeX / MiKTeX 任一即可，2021 或更新）。

```bash
git clone <your-repo-url> && cd kuolie
latexmk            # 生成 main.pdf 和 example-cute.pdf
```

如果不用 latexmk：

```bash
xelatex main.tex
```

**必须用 XeLaTeX。** 用 pdfLaTeX 或 LuaLaTeX 跑不通。`main.tex` 顶部有 `% !TeX program = xelatex` 注释，正常情况下编辑器会自动切换。

### Overleaf

1. 打包整个仓库上传（`New Project → Upload Project`），或者 `Import from GitHub`。
2. 左上角 `Menu → Compiler` 选 **XeLaTeX**。
3. `Main document` 选 `main.tex`。

---

## 换成你自己的内容

`content/` 里放的是作者本人的资料，直接覆盖就好（请同好来找我扩列！

**改文字**：编辑 `content/` 下面的六个文件。每个文件对应一个小节，格式看文件开头的注释。

**增删小节**：小节是在 `main.tex` 里一节一节拼出来的。每节两行（标题+内容）：

```latex
\input{content/profile}        % 身份卡,不需要 \kuoliesection

\kuoliesection{我推和坑}
\input{content/oshi}

\kuoliesection{关于音乐}
\input{content/music}
```

不想要「关于观鸟」，把那两行删掉（`content/birding.tex` 可以保留）。如果想加一节「关于游戏」，新建 `content/games.tex`，在 `main.tex` 里照样写两行。小节标题自定，`highlight` 键控制前几个字的强调色。

新小节的正文排版：

| 想要的效果 | 用什么 | 现成例子 |
| --- | --- | --- |
| 双栏「作品-角色」 | `pairlist` + `\pair` | `oshi.tex`、`ships.tex` |
| 通栏条目列表 | `kuolieitems` + `\item` | `music.tex`、`birding.tex`、`notes.tex` |
| 末尾的小字附注 | `\kuolienote` | `oshi.tex` |

**改样式**：只改 `main.tex` 顶部的 `\kuoliesetup`，见下面的选项表。

用不上第二个示例就把 `example-cute.tex` 删掉。

---

## 字体

**西文**用 Source Sans 3 和 Roboto，文件就在 `fonts/` 里，按**文件名**加载。

**中文字体没法打包**，模板自动探测。`fontset=auto`（默认）按这个顺序找：

| 顺序 | 字体 | 说明 |
| --- | --- | --- |
| 1 | Noto Sans CJK SC | 推荐。免费、跨平台、Overleaf 自带 |
| 2 | Source Han Sans SC | 思源黑体，和 Noto 同源同形 |
| 3 | Noto Sans SC | Google Fonts 版命名 |
| 4 | PingFang SC | macOS 自带 |
| 5 | Microsoft YaHei | Windows 自带 |
| 6 | Hiragino Sans GB | 旧版 macOS |
| 7 | **Fandol** | TeX Live 自带，零安装，保底 |

### Fandol 的字符集有缺口

保底用的 Fandol 只覆盖常用简体字，仓库自带的这份内容在 Fandol 下就少两个字：「再见菈菈」的**菈**（U+83C8）和「鹟科」的**鹟**（U+9E5F），PDF 里是空白。日文汉字同理，比如「牛**込**里美」的込。

落到 Fandol 时编译日志里会有这条：

```
Class kuolie Warning: Falling back to the Fandol fonts...
```

看到这条警告，请安装 Noto Sans CJK SC：

```bash
# macOS
brew install --cask font-noto-sans-cjk

# Debian / Ubuntu
sudo apt install fonts-noto-cjk

# Windows / 其它
# 从 https://github.com/notofonts/noto-cjk/releases 下载 NotoSansCJKsc 后双击安装
```

装完重新编译即可。也可以显式写死 `fontset=noto`。

想用别的字体：

```latex
\kuoliesetcjkfont{霞鹜文楷}                       % 按字体族名
\kuoliesetcjkfont{LXGWWenKai-Regular.ttf}[BoldFont=LXGWWenKai-Bold.ttf]
```

---

## 目录结构

```
kuolie.cls            排版引擎，一般不用动
main.tex              样式配置 + 小节装配，改样式只看这个文件
example-cute.tex      第二种风格示例，复用同一份 content/
content/
  profile.tex           身份卡
  oshi.tex              我推和坑     双栏 pairlist
  ships.tex             关于 CP      双栏 pairlist
  music.tex             关于音乐     通栏列表，乐队名标色
  birding.tex           关于观鸟     通栏列表
  notes.tex             碎碎念       通栏列表
fonts/                随仓库分发的西文字体，OFL / Apache 2.0
docs/                 README 里的预览图
```

---

## `\kuoliesetup` 选项

全部写在 `main.tex` 里。选项块中间**可以留空行**分组。

| 键 | 取值 | 默认 | 说明 |
| --- | --- | --- | --- |
| `accent` | `emerald` `skyblue` `red` `pink` `orange` `nephritis` `concrete` `darknight` `sakura` `lavender` `cyan` `mint` | `skyblue` | 强调色。前八个是 Awesome-CV 原配色 |
| `accenthex` | 六位十六进制，如 `EF4089` | — | 自定义强调色，**不要写 `#`**。给了就覆盖 `accent` |
| `fontset` | `auto` `noto` `sourcehan` `notosc` `fandol` `macos` `windows` | `auto` | 中文字体，见上一节 |
| `paper` | `a4` `letter` `square` `poster` | `a4` | `square` 是 176×220mm（4:5） |
| `cardstyle` | `flat` `soft` | `flat` | `flat` 纯白；`soft` 淡色底 + 白色圆角卡 |
| `background` | 任意颜色名，或 `none` | 跟随 `cardstyle` | 页面底色。`none` = 不画底，PDF 背景透明 |
| `backgroundhex` | 六位十六进制 | — | 自定义页面底色，**不要写 `#`** |
| `divider` | `rule` `dots` `hearts` `none` | `rule` | 小标题右侧的填充线 |
| `dividertint` | 任意颜色名 | `kuolie-graytext` | 分隔线颜色 |
| `columns` | 整数 | `2` | `pairlist` 的栏数 |
| `highlight` | 整数 | `2` | 小标题前几个字用强调色。`0` = 都不用，`99` = 全部 |
| `titlespread` | 小数 | `0.06` | 小标题字距（em）。`0` = 不加 |
| `columnsep` | 长度 | `2.2em` | 双栏间距 |
| `pairdelim` | 任意代码 | 浅灰间隔点 | `\pair` 的键值分隔符 |
| `tagsep` | 任意代码 | 浅灰竖线 | 标签之间的「｜」 |
| `sectionsep` | 长度 | `4.2mm` | 小标题上方留白 |
| `contentsep` | 长度 | `2.4mm` | 小标题到内容 |
| `pairsep` | 长度 | `1.5mm` | 双栏条目行距 |
| `itemsep` | 长度 | `1.1mm` | 列表条目行距 |
| `iconwidth` | 长度 | `1.2em` | 身份卡图标的固定框宽 |
| `iconsep` | 长度 | `0.3em` | 图标到文字的间距 |

`sectionsep` / `contentsep` / `pairsep` / `itemsep` 是**竖向排版节奏**参数，排到两页时先调整这些内容。

`iconwidth` 存在的原因：Font Awesome 的图标不等宽（`\faUser` 是 0.875em，`\faHeart` 是 1.0em），按自然宽度排会让每行文字的起点错开。图标被装进固定宽度的居中盒子里，所以标签块的左边缘是齐的。用了特别宽的图标（比如 `\faGamepad`）就把这个值调大。

---

## 内容宏

### 身份卡（`content/profile.tex`）

```latex
\name{雨迹 / 远环蚓}
\alias{可以叫我老雨 / 蚯蚓 / 土泥棒以及各种变体（？}

\profileline[\faUser]{双鱼座, 大学在读, inxj}
\profileline[\faHeart]{观鸟爱好者, 画画低手, sf 系漫画爱好者}

\makekuolieheader[L]        % [L] 左 / [C] 居中(默认) / [R] 右
```

- `\profileline` 的内容用**英文逗号**分隔，「｜」分隔符会自动加，不需要自己输入
- 中括号里是图标，可省略。图标名见 [fontawesome5 手册](https://mirrors.ctan.org/fonts/fontawesome5/doc/fontawesome5.pdf)，常用的有 `\faUser` `\faHeart` `\faStar` `\faInfoCircle` `\faCommentDots` `\faGamepad` `\faMusic` `\faPalette`。

头像默认不放。想放的话，建个 `assets/` 把图放进去，然后取消 `main.tex` 里那行的注释：

```latex
\photo[circle, noedge, left]{assets/avatar.jpg}
% 形状 circle|rectangle，描边 edge|noedge，位置 left|right
```

支持 JPG / PNG / PDF，会占掉头部约四分之一宽度，并随纸张大小缩放。

### 双栏列表

```latex
\kuoliesection{我推和坑}
\begin{pairlist}
  \pair{摇曳百合}{船见结衣}
  \pair{金牌得主}{依实依 / 光祈}
  \pair{只写作品名}{}
\end{pairlist}
\kuolienote{这里是小字附注。}
```

- **按列填充**：左栏先填满再溢到右栏（7 项 → 左 4 右 3），和手写扩列图的读法一致。
- `\pair` 之间**不要留空行**。
- `\kuolietags{甲, 乙, 丙}` 可以在附注里生成「甲｜乙｜丙」这样的标签串。

### 碎碎念

```latex
\kuoliesection{一些碎碎念}
\begin{kuolieitems}
  \item \kuoliehl{这句话会用强调色加粗}，后面是正常文字。
  \item 第二条。
\end{kuolieitems}
\kuolieclosing{好啦我说完了!! 感谢您的阅读}
```

### 页脚（可选）

```latex
\makekuoliefooter{左}{中}{右}
```

---

## 导出成图片

正常人类应该扩列不会发pdf？：PDF 转 PNG：

```bash
# ImageMagick
magick -density 300 main.pdf -quality 95 main.png

# poppler
pdftoppm -r 300 -png main.pdf main

# macOS 自带，不用装东西
sips -s format png -Z 2000 main.pdf --out main.png
```

内容不多的话配 `paper=square`（4:5）效果大概会比较好（？

PDF 是**自带白底**的，转出来的 PNG 不会透明。想要透明背景（比如要抠出来自己合成）就设 `background=none`。

---

## 常见问题

**排到两页了怎么办**
按效果排序：

1. 调竖向节奏 —— `sectionsep=3.4mm, contentsep=2.0mm, pairsep=1.2mm, itemsep=0.9mm`。
2. 换 `paper=a4`。`square` 只够放比较精简的内容。
3. `cardstyle=flat`：`soft` 的圆角卡会多吃掉约 11mm。
4. 精简 `\pair` 条目 / 把 `\kuolienote` 写短一点 / `columns=3`。

**编译报错说要 XeTeX：**
用了 pdfLaTeX 或 LuaLaTeX。改用 XeLaTeX。

**中文变成方块：**
落到 Fandol 了，而且用到了没有的字。装 Noto Sans CJK SC，见上文。日志里搜 `Missing character` 能看到具体是哪几个字。

**`\profileline` 里想用逗号本身：**
用花括号裹起来：`\profileline{{甲, 乙}, 丙}` 会输出两项。

**小标题「关于CP」着色位置不对：**
`highlight` 是按**字符数**算的，中英混排时数一下实际字符。`关于CP` 的前 2 字是「关于」，所以刚刚好。

---

## 致谢与许可

排版语言来自 [posquit0/Awesome-CV](https://github.com/posquit0/Awesome-CV)（MIT）。信息结构来自中文互联网上流传已久的手写扩列图格式。

模板代码 MIT 许可。`fonts/` 下的字体各自适用 OFL 1.1 / Apache 2.0，详见 [LICENSE](LICENSE)。

---

## Have fun :)