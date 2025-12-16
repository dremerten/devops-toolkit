/**
 * This file was generated from regexp.peg
 * See https://canopy.jcoglan.com/ for documentation
 */

(function () {
  'use strict';

  function TreeNode (text, offset, elements) {
    this.text = text;
    this.offset = offset;
    this.elements = elements;
  }

  TreeNode.prototype.forEach = function (block, context) {
    for (var el = this.elements, i = 0, n = el.length; i < n; i++) {
      block.call(context, el[i], i, el);
    }
  };

  if (typeof Symbol !== 'undefined' && Symbol.iterator) {
    TreeNode.prototype[Symbol.iterator] = function () {
      return this.elements[Symbol.iterator]();
    };
  }

  var TreeNode1 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['regexp'] = elements[1];
    this['flags'] = elements[3];
  };
  inherit(TreeNode1, TreeNode);

  var TreeNode2 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['regexp'] = elements[0];
    this['flags'] = elements[1];
  };
  inherit(TreeNode2, TreeNode);

  var TreeNode3 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['match'] = elements[0];
    this['alternates'] = elements[1];
  };
  inherit(TreeNode3, TreeNode);

  var TreeNode4 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['match'] = elements[1];
  };
  inherit(TreeNode4, TreeNode);

  var TreeNode5 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['parts'] = elements[1];
  };
  inherit(TreeNode5, TreeNode);

  var TreeNode6 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['content'] = elements[0];
    this['repeat'] = elements[1];
  };
  inherit(TreeNode6, TreeNode);

  var TreeNode7 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['spec'] = elements[0];
    this['greedy'] = elements[1];
  };
  inherit(TreeNode7, TreeNode);

  var TreeNode8 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['min'] = elements[1];
    this['max'] = elements[3];
  };
  inherit(TreeNode8, TreeNode);

  var TreeNode9 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['min'] = elements[1];
  };
  inherit(TreeNode9, TreeNode);

  var TreeNode10 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['exact'] = elements[1];
  };
  inherit(TreeNode10, TreeNode);

  var TreeNode11 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['capture'] = elements[1];
    this['regexp'] = elements[2];
  };
  inherit(TreeNode11, TreeNode);

  var TreeNode12 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['invert'] = elements[1];
    this['parts'] = elements[2];
  };
  inherit(TreeNode12, TreeNode);

  var TreeNode13 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['first'] = elements[0];
    this['charset_range_terminal'] = elements[2];
    this['last'] = elements[2];
  };
  inherit(TreeNode13, TreeNode);

  var TreeNode14 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['esc'] = elements[1];
  };
  inherit(TreeNode14, TreeNode);

  var TreeNode15 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode15, TreeNode);

  var TreeNode16 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['esc'] = elements[1];
  };
  inherit(TreeNode16, TreeNode);

  var TreeNode17 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode17, TreeNode);

  var TreeNode18 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['literal'] = elements[1];
  };
  inherit(TreeNode18, TreeNode);

  var TreeNode19 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['literal'] = elements[0];
  };
  inherit(TreeNode19, TreeNode);

  var TreeNode20 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['literal'] = elements[1];
  };
  inherit(TreeNode20, TreeNode);

  var TreeNode21 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['literal'] = elements[1];
  };
  inherit(TreeNode21, TreeNode);

  var TreeNode22 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['literal'] = elements[0];
  };
  inherit(TreeNode22, TreeNode);

  var TreeNode23 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['literal'] = elements[1];
  };
  inherit(TreeNode23, TreeNode);

  var TreeNode24 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode24, TreeNode);

  var TreeNode25 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode25, TreeNode);

  var TreeNode26 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode26, TreeNode);

  var TreeNode27 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode27, TreeNode);

  var TreeNode28 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode28, TreeNode);

  var TreeNode29 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['esc'] = elements[1];
  };
  inherit(TreeNode29, TreeNode);

  var TreeNode30 = function (text, offset, elements) {
    TreeNode.apply(this, arguments);
    this['code'] = elements[0];
    this['arg'] = elements[1];
  };
  inherit(TreeNode30, TreeNode);

  var FAILURE = {};

  var Grammar = {
    _read_root () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._root = this._cache._root || {};
      var cached = this._cache._root[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      var index2 = this._offset, elements0 = new Array(4);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '/') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::root', '"/"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        address2 = this._read_regexp();
        if (address2 !== FAILURE) {
          elements0[1] = address2;
          var address3 = FAILURE;
          var chunk1 = null, max1 = this._offset + 1;
          if (max1 <= this._inputSize) {
            chunk1 = this._input.substring(this._offset, max1);
          }
          if (chunk1 === '/') {
            address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address3 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::root', '"/"']);
            }
          }
          if (address3 !== FAILURE) {
            elements0[2] = address3;
            var address4 = FAILURE;
            var index3 = this._offset, elements1 = [], address5 = null;
            while (true) {
              var chunk2 = null, max2 = this._offset + 1;
              if (max2 <= this._inputSize) {
                chunk2 = this._input.substring(this._offset, max2);
              }
              if (chunk2 !== null && /^[yigmu]/.test(chunk2)) {
                address5 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
                this._offset = this._offset + 1;
              } else {
                address5 = FAILURE;
                if (this._offset > this._failure) {
                  this._failure = this._offset;
                  this._expected = [];
                }
                if (this._offset === this._failure) {
                  this._expected.push(['JavaScriptRegexp::root', '[yigmu]']);
                }
              }
              if (address5 !== FAILURE) {
                elements1.push(address5);
              } else {
                break;
              }
            }
            if (elements1.length >= 0) {
              address4 = new TreeNode(this._input.substring(index3, this._offset), index3, elements1);
              this._offset = this._offset;
            } else {
              address4 = FAILURE;
            }
            if (address4 !== FAILURE) {
              elements0[3] = address4;
            } else {
              elements0 = null;
              this._offset = index2;
            }
          } else {
            elements0 = null;
            this._offset = index2;
          }
        } else {
          elements0 = null;
          this._offset = index2;
        }
      } else {
        elements0 = null;
        this._offset = index2;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode1(this._input.substring(index2, this._offset), index2, elements0);
        this._offset = this._offset;
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        var index4 = this._offset, elements2 = new Array(2);
        var address6 = FAILURE;
        address6 = this._read_regexp();
        if (address6 !== FAILURE) {
          elements2[0] = address6;
          var address7 = FAILURE;
          var index5 = this._offset;
          var chunk3 = null, max3 = this._offset + 0;
          if (max3 <= this._inputSize) {
            chunk3 = this._input.substring(this._offset, max3);
          }
          if (chunk3 === '') {
            address7 = new TreeNode(this._input.substring(this._offset, this._offset + 0), this._offset, []);
            this._offset = this._offset + 0;
          } else {
            address7 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::root', '""']);
            }
          }
          if (address7 === FAILURE) {
            address7 = new TreeNode(this._input.substring(index5, index5), index5, []);
            this._offset = index5;
          }
          if (address7 !== FAILURE) {
            elements2[1] = address7;
          } else {
            elements2 = null;
            this._offset = index4;
          }
        } else {
          elements2 = null;
          this._offset = index4;
        }
        if (elements2 === null) {
          address0 = FAILURE;
        } else {
          address0 = new TreeNode2(this._input.substring(index4, this._offset), index4, elements2);
          this._offset = this._offset;
        }
        if (address0 === FAILURE) {
          this._offset = index1;
        }
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.Root);
      }
      this._cache._root[index0] = [address0, this._offset];
      return address0;
    },

    _read_regexp () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._regexp = this._cache._regexp || {};
      var cached = this._cache._regexp[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      address1 = this._read_match();
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset, elements1 = [], address3 = null;
        while (true) {
          var index3 = this._offset, elements2 = new Array(2);
          var address4 = FAILURE;
          var chunk0 = null, max0 = this._offset + 1;
          if (max0 <= this._inputSize) {
            chunk0 = this._input.substring(this._offset, max0);
          }
          if (chunk0 === '|') {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::regexp', '"|"']);
            }
          }
          if (address4 !== FAILURE) {
            elements2[0] = address4;
            var address5 = FAILURE;
            address5 = this._read_match();
            if (address5 !== FAILURE) {
              elements2[1] = address5;
            } else {
              elements2 = null;
              this._offset = index3;
            }
          } else {
            elements2 = null;
            this._offset = index3;
          }
          if (elements2 === null) {
            address3 = FAILURE;
          } else {
            address3 = new TreeNode4(this._input.substring(index3, this._offset), index3, elements2);
            this._offset = this._offset;
          }
          if (address3 !== FAILURE) {
            elements1.push(address3);
          } else {
            break;
          }
        }
        if (elements1.length >= 0) {
          address2 = new TreeNode(this._input.substring(index2, this._offset), index2, elements1);
          this._offset = this._offset;
        } else {
          address2 = FAILURE;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode3(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.Regexp);
      }
      this._cache._regexp[index0] = [address0, this._offset];
      return address0;
    },

    _read_match () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._match = this._cache._match || {};
      var cached = this._cache._match[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var index2 = this._offset;
      address1 = this._read_repeat();
      this._offset = index2;
      if (address1 === FAILURE) {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset), this._offset, []);
        this._offset = this._offset;
      } else {
        address1 = FAILURE;
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index3 = this._offset, elements1 = [], address3 = null;
        while (true) {
          address3 = this._read_match_fragment();
          if (address3 !== FAILURE) {
            elements1.push(address3);
          } else {
            break;
          }
        }
        if (elements1.length >= 0) {
          address2 = new TreeNode(this._input.substring(index3, this._offset), index3, elements1);
          this._offset = this._offset;
        } else {
          address2 = FAILURE;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode5(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.Match);
      }
      this._cache._match[index0] = [address0, this._offset];
      return address0;
    },

    _read_match_fragment () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._match_fragment = this._cache._match_fragment || {};
      var cached = this._cache._match_fragment[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var index2 = this._offset;
      address1 = this._read_anchor();
      if (address1 === FAILURE) {
        this._offset = index2;
        address1 = this._read_subexp();
        if (address1 === FAILURE) {
          this._offset = index2;
          address1 = this._read_charset();
          if (address1 === FAILURE) {
            this._offset = index2;
            address1 = this._read_terminal();
            if (address1 === FAILURE) {
              this._offset = index2;
            }
          }
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index3 = this._offset;
        address2 = this._read_repeat();
        if (address2 === FAILURE) {
          address2 = new TreeNode(this._input.substring(index3, index3), index3, []);
          this._offset = index3;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode6(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.MatchFragment);
      }
      this._cache._match_fragment[index0] = [address0, this._offset];
      return address0;
    },

    _read_repeat () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._repeat = this._cache._repeat || {};
      var cached = this._cache._repeat[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var index2 = this._offset;
      address1 = this._read_repeat_any();
      if (address1 === FAILURE) {
        this._offset = index2;
        address1 = this._read_repeat_required();
        if (address1 === FAILURE) {
          this._offset = index2;
          address1 = this._read_repeat_optional();
          if (address1 === FAILURE) {
            this._offset = index2;
            address1 = this._read_repeat_spec();
            if (address1 === FAILURE) {
              this._offset = index2;
            }
          }
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index3 = this._offset;
        var chunk0 = null, max0 = this._offset + 1;
        if (max0 <= this._inputSize) {
          chunk0 = this._input.substring(this._offset, max0);
        }
        if (chunk0 === '?') {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::repeat', '"?"']);
          }
        }
        if (address2 === FAILURE) {
          address2 = new TreeNode(this._input.substring(index3, index3), index3, []);
          this._offset = index3;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode7(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.Repeat);
      }
      this._cache._repeat[index0] = [address0, this._offset];
      return address0;
    },

    _read_repeat_any () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._repeat_any = this._cache._repeat_any || {};
      var cached = this._cache._repeat_any[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '*') {
        address0 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address0 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::repeat_any', '"*"']);
        }
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.RepeatAny);
      }
      this._cache._repeat_any[index0] = [address0, this._offset];
      return address0;
    },

    _read_repeat_required () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._repeat_required = this._cache._repeat_required || {};
      var cached = this._cache._repeat_required[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '+') {
        address0 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address0 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::repeat_required', '"+"']);
        }
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.RepeatRequired);
      }
      this._cache._repeat_required[index0] = [address0, this._offset];
      return address0;
    },

    _read_repeat_optional () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._repeat_optional = this._cache._repeat_optional || {};
      var cached = this._cache._repeat_optional[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '?') {
        address0 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address0 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::repeat_optional', '"?"']);
        }
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.RepeatOptional);
      }
      this._cache._repeat_optional[index0] = [address0, this._offset];
      return address0;
    },

    _read_repeat_spec () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._repeat_spec = this._cache._repeat_spec || {};
      var cached = this._cache._repeat_spec[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      var index2 = this._offset, elements0 = new Array(5);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '{') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::repeat_spec', '"{"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index3 = this._offset, elements1 = [], address3 = null;
        while (true) {
          var chunk1 = null, max1 = this._offset + 1;
          if (max1 <= this._inputSize) {
            chunk1 = this._input.substring(this._offset, max1);
          }
          if (chunk1 !== null && /^[0-9]/.test(chunk1)) {
            address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address3 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::repeat_spec', '[0-9]']);
            }
          }
          if (address3 !== FAILURE) {
            elements1.push(address3);
          } else {
            break;
          }
        }
        if (elements1.length >= 1) {
          address2 = new TreeNode(this._input.substring(index3, this._offset), index3, elements1);
          this._offset = this._offset;
        } else {
          address2 = FAILURE;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
          var address4 = FAILURE;
          var chunk2 = null, max2 = this._offset + 1;
          if (max2 <= this._inputSize) {
            chunk2 = this._input.substring(this._offset, max2);
          }
          if (chunk2 === ',') {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::repeat_spec', '","']);
            }
          }
          if (address4 !== FAILURE) {
            elements0[2] = address4;
            var address5 = FAILURE;
            var index4 = this._offset, elements2 = [], address6 = null;
            while (true) {
              var chunk3 = null, max3 = this._offset + 1;
              if (max3 <= this._inputSize) {
                chunk3 = this._input.substring(this._offset, max3);
              }
              if (chunk3 !== null && /^[0-9]/.test(chunk3)) {
                address6 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
                this._offset = this._offset + 1;
              } else {
                address6 = FAILURE;
                if (this._offset > this._failure) {
                  this._failure = this._offset;
                  this._expected = [];
                }
                if (this._offset === this._failure) {
                  this._expected.push(['JavaScriptRegexp::repeat_spec', '[0-9]']);
                }
              }
              if (address6 !== FAILURE) {
                elements2.push(address6);
              } else {
                break;
              }
            }
            if (elements2.length >= 1) {
              address5 = new TreeNode(this._input.substring(index4, this._offset), index4, elements2);
              this._offset = this._offset;
            } else {
              address5 = FAILURE;
            }
            if (address5 !== FAILURE) {
              elements0[3] = address5;
              var address7 = FAILURE;
              var chunk4 = null, max4 = this._offset + 1;
              if (max4 <= this._inputSize) {
                chunk4 = this._input.substring(this._offset, max4);
              }
              if (chunk4 === '}') {
                address7 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
                this._offset = this._offset + 1;
              } else {
                address7 = FAILURE;
                if (this._offset > this._failure) {
                  this._failure = this._offset;
                  this._expected = [];
                }
                if (this._offset === this._failure) {
                  this._expected.push(['JavaScriptRegexp::repeat_spec', '"}"']);
                }
              }
              if (address7 !== FAILURE) {
                elements0[4] = address7;
              } else {
                elements0 = null;
                this._offset = index2;
              }
            } else {
              elements0 = null;
              this._offset = index2;
            }
          } else {
            elements0 = null;
            this._offset = index2;
          }
        } else {
          elements0 = null;
          this._offset = index2;
        }
      } else {
        elements0 = null;
        this._offset = index2;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode8(this._input.substring(index2, this._offset), index2, elements0);
        this._offset = this._offset;
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        var index5 = this._offset, elements3 = new Array(3);
        var address8 = FAILURE;
        var chunk5 = null, max5 = this._offset + 1;
        if (max5 <= this._inputSize) {
          chunk5 = this._input.substring(this._offset, max5);
        }
        if (chunk5 === '{') {
          address8 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address8 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::repeat_spec', '"{"']);
          }
        }
        if (address8 !== FAILURE) {
          elements3[0] = address8;
          var address9 = FAILURE;
          var index6 = this._offset, elements4 = [], address10 = null;
          while (true) {
            var chunk6 = null, max6 = this._offset + 1;
            if (max6 <= this._inputSize) {
              chunk6 = this._input.substring(this._offset, max6);
            }
            if (chunk6 !== null && /^[0-9]/.test(chunk6)) {
              address10 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
              this._offset = this._offset + 1;
            } else {
              address10 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::repeat_spec', '[0-9]']);
              }
            }
            if (address10 !== FAILURE) {
              elements4.push(address10);
            } else {
              break;
            }
          }
          if (elements4.length >= 1) {
            address9 = new TreeNode(this._input.substring(index6, this._offset), index6, elements4);
            this._offset = this._offset;
          } else {
            address9 = FAILURE;
          }
          if (address9 !== FAILURE) {
            elements3[1] = address9;
            var address11 = FAILURE;
            var chunk7 = null, max7 = this._offset + 2;
            if (max7 <= this._inputSize) {
              chunk7 = this._input.substring(this._offset, max7);
            }
            if (chunk7 === ',}') {
              address11 = new TreeNode(this._input.substring(this._offset, this._offset + 2), this._offset, []);
              this._offset = this._offset + 2;
            } else {
              address11 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::repeat_spec', '",}"']);
              }
            }
            if (address11 !== FAILURE) {
              elements3[2] = address11;
            } else {
              elements3 = null;
              this._offset = index5;
            }
          } else {
            elements3 = null;
            this._offset = index5;
          }
        } else {
          elements3 = null;
          this._offset = index5;
        }
        if (elements3 === null) {
          address0 = FAILURE;
        } else {
          address0 = new TreeNode9(this._input.substring(index5, this._offset), index5, elements3);
          this._offset = this._offset;
        }
        if (address0 === FAILURE) {
          this._offset = index1;
          var index7 = this._offset, elements5 = new Array(3);
          var address12 = FAILURE;
          var chunk8 = null, max8 = this._offset + 1;
          if (max8 <= this._inputSize) {
            chunk8 = this._input.substring(this._offset, max8);
          }
          if (chunk8 === '{') {
            address12 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address12 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::repeat_spec', '"{"']);
            }
          }
          if (address12 !== FAILURE) {
            elements5[0] = address12;
            var address13 = FAILURE;
            var index8 = this._offset, elements6 = [], address14 = null;
            while (true) {
              var chunk9 = null, max9 = this._offset + 1;
              if (max9 <= this._inputSize) {
                chunk9 = this._input.substring(this._offset, max9);
              }
              if (chunk9 !== null && /^[0-9]/.test(chunk9)) {
                address14 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
                this._offset = this._offset + 1;
              } else {
                address14 = FAILURE;
                if (this._offset > this._failure) {
                  this._failure = this._offset;
                  this._expected = [];
                }
                if (this._offset === this._failure) {
                  this._expected.push(['JavaScriptRegexp::repeat_spec', '[0-9]']);
                }
              }
              if (address14 !== FAILURE) {
                elements6.push(address14);
              } else {
                break;
              }
            }
            if (elements6.length >= 1) {
              address13 = new TreeNode(this._input.substring(index8, this._offset), index8, elements6);
              this._offset = this._offset;
            } else {
              address13 = FAILURE;
            }
            if (address13 !== FAILURE) {
              elements5[1] = address13;
              var address15 = FAILURE;
              var chunk10 = null, max10 = this._offset + 1;
              if (max10 <= this._inputSize) {
                chunk10 = this._input.substring(this._offset, max10);
              }
              if (chunk10 === '}') {
                address15 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
                this._offset = this._offset + 1;
              } else {
                address15 = FAILURE;
                if (this._offset > this._failure) {
                  this._failure = this._offset;
                  this._expected = [];
                }
                if (this._offset === this._failure) {
                  this._expected.push(['JavaScriptRegexp::repeat_spec', '"}"']);
                }
              }
              if (address15 !== FAILURE) {
                elements5[2] = address15;
              } else {
                elements5 = null;
                this._offset = index7;
              }
            } else {
              elements5 = null;
              this._offset = index7;
            }
          } else {
            elements5 = null;
            this._offset = index7;
          }
          if (elements5 === null) {
            address0 = FAILURE;
          } else {
            address0 = new TreeNode10(this._input.substring(index7, this._offset), index7, elements5);
            this._offset = this._offset;
          }
          if (address0 === FAILURE) {
            this._offset = index1;
          }
        }
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.RepeatSpec);
      }
      this._cache._repeat_spec[index0] = [address0, this._offset];
      return address0;
    },

    _read_anchor () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._anchor = this._cache._anchor || {};
      var cached = this._cache._anchor[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '^') {
        address0 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address0 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::anchor', '"^"']);
        }
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 === '$') {
          address0 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address0 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::anchor', '"$"']);
          }
        }
        if (address0 === FAILURE) {
          this._offset = index1;
        }
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.Anchor);
      }
      this._cache._anchor[index0] = [address0, this._offset];
      return address0;
    },

    _read_subexp () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._subexp = this._cache._subexp || {};
      var cached = this._cache._subexp[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(4);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '(') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::subexp', '"("']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset;
        var index3 = this._offset;
        var chunk1 = null, max1 = this._offset + 2;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 === '?:') {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 2), this._offset, []);
          this._offset = this._offset + 2;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::subexp', '"?:"']);
          }
        }
        if (address2 === FAILURE) {
          this._offset = index3;
          var chunk2 = null, max2 = this._offset + 2;
          if (max2 <= this._inputSize) {
            chunk2 = this._input.substring(this._offset, max2);
          }
          if (chunk2 === '?=') {
            address2 = new TreeNode(this._input.substring(this._offset, this._offset + 2), this._offset, []);
            this._offset = this._offset + 2;
          } else {
            address2 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::subexp', '"?="']);
            }
          }
          if (address2 === FAILURE) {
            this._offset = index3;
            var chunk3 = null, max3 = this._offset + 2;
            if (max3 <= this._inputSize) {
              chunk3 = this._input.substring(this._offset, max3);
            }
            if (chunk3 === '?!') {
              address2 = new TreeNode(this._input.substring(this._offset, this._offset + 2), this._offset, []);
              this._offset = this._offset + 2;
            } else {
              address2 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::subexp', '"?!"']);
              }
            }
            if (address2 === FAILURE) {
              this._offset = index3;
            }
          }
        }
        if (address2 === FAILURE) {
          address2 = new TreeNode(this._input.substring(index2, index2), index2, []);
          this._offset = index2;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
          var address3 = FAILURE;
          address3 = this._read_regexp();
          if (address3 !== FAILURE) {
            elements0[2] = address3;
            var address4 = FAILURE;
            var chunk4 = null, max4 = this._offset + 1;
            if (max4 <= this._inputSize) {
              chunk4 = this._input.substring(this._offset, max4);
            }
            if (chunk4 === ')') {
              address4 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
              this._offset = this._offset + 1;
            } else {
              address4 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::subexp', '")"']);
              }
            }
            if (address4 !== FAILURE) {
              elements0[3] = address4;
            } else {
              elements0 = null;
              this._offset = index1;
            }
          } else {
            elements0 = null;
            this._offset = index1;
          }
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode11(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.Subexp);
      }
      this._cache._subexp[index0] = [address0, this._offset];
      return address0;
    },

    _read_charset () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._charset = this._cache._charset || {};
      var cached = this._cache._charset[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(4);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '[') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::charset', '"["']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 === '^') {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::charset', '"^"']);
          }
        }
        if (address2 === FAILURE) {
          address2 = new TreeNode(this._input.substring(index2, index2), index2, []);
          this._offset = index2;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
          var address3 = FAILURE;
          var index3 = this._offset, elements1 = [], address4 = null;
          while (true) {
            var index4 = this._offset;
            address4 = this._read_charset_range();
            if (address4 === FAILURE) {
              this._offset = index4;
              address4 = this._read_charset_terminal();
              if (address4 === FAILURE) {
                this._offset = index4;
              }
            }
            if (address4 !== FAILURE) {
              elements1.push(address4);
            } else {
              break;
            }
          }
          if (elements1.length >= 0) {
            address3 = new TreeNode(this._input.substring(index3, this._offset), index3, elements1);
            this._offset = this._offset;
          } else {
            address3 = FAILURE;
          }
          if (address3 !== FAILURE) {
            elements0[2] = address3;
            var address5 = FAILURE;
            var chunk2 = null, max2 = this._offset + 1;
            if (max2 <= this._inputSize) {
              chunk2 = this._input.substring(this._offset, max2);
            }
            if (chunk2 === ']') {
              address5 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
              this._offset = this._offset + 1;
            } else {
              address5 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::charset', '"]"']);
              }
            }
            if (address5 !== FAILURE) {
              elements0[3] = address5;
            } else {
              elements0 = null;
              this._offset = index1;
            }
          } else {
            elements0 = null;
            this._offset = index1;
          }
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode12(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.Charset);
      }
      this._cache._charset[index0] = [address0, this._offset];
      return address0;
    },

    _read_charset_range () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._charset_range = this._cache._charset_range || {};
      var cached = this._cache._charset_range[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(3);
      var address1 = FAILURE;
      address1 = this._read_charset_range_terminal();
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var chunk0 = null, max0 = this._offset + 1;
        if (max0 <= this._inputSize) {
          chunk0 = this._input.substring(this._offset, max0);
        }
        if (chunk0 === '-') {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::charset_range', '"-"']);
          }
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
          var address3 = FAILURE;
          address3 = this._read_charset_range_terminal();
          if (address3 !== FAILURE) {
            elements0[2] = address3;
          } else {
            elements0 = null;
            this._offset = index1;
          }
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode13(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.CharsetRange);
      }
      this._cache._charset_range[index0] = [address0, this._offset];
      return address0;
    },

    _read_charset_range_terminal () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._charset_range_terminal = this._cache._charset_range_terminal || {};
      var cached = this._cache._charset_range_terminal[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      address0 = this._read_charset_range_escape();
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.CharsetEscape);
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        address0 = this._read_charset_literal();
        if (address0 !== FAILURE) {
          Object.assign(address0, this._types.Literal);
        }
        if (address0 === FAILURE) {
          this._offset = index1;
        }
      }
      this._cache._charset_range_terminal[index0] = [address0, this._offset];
      return address0;
    },

    _read_charset_terminal () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._charset_terminal = this._cache._charset_terminal || {};
      var cached = this._cache._charset_terminal[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      address0 = this._read_charset_escape();
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.CharsetEscape);
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        address0 = this._read_charset_literal();
        if (address0 !== FAILURE) {
          Object.assign(address0, this._types.Literal);
        }
        if (address0 === FAILURE) {
          this._offset = index1;
        }
      }
      this._cache._charset_terminal[index0] = [address0, this._offset];
      return address0;
    },

    _read_charset_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._charset_escape = this._cache._charset_escape || {};
      var cached = this._cache._charset_escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '\\') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::charset_escape', '"\\\\"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset;
        var index3 = this._offset, elements1 = new Array(2);
        var address3 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[bdDfnrsStvwW]/.test(chunk1)) {
          address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address3 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::charset_escape', '[bdDfnrsStvwW]']);
          }
        }
        if (address3 !== FAILURE) {
          elements1[0] = address3;
          var address4 = FAILURE;
          var index4 = this._offset;
          var chunk2 = null, max2 = this._offset + 0;
          if (max2 <= this._inputSize) {
            chunk2 = this._input.substring(this._offset, max2);
          }
          if (chunk2 === '') {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 0), this._offset, []);
            this._offset = this._offset + 0;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::charset_escape', '""']);
            }
          }
          if (address4 === FAILURE) {
            address4 = new TreeNode(this._input.substring(index4, index4), index4, []);
            this._offset = index4;
          }
          if (address4 !== FAILURE) {
            elements1[1] = address4;
          } else {
            elements1 = null;
            this._offset = index3;
          }
        } else {
          elements1 = null;
          this._offset = index3;
        }
        if (elements1 === null) {
          address2 = FAILURE;
        } else {
          address2 = new TreeNode15(this._input.substring(index3, this._offset), index3, elements1);
          this._offset = this._offset;
        }
        if (address2 === FAILURE) {
          this._offset = index2;
          address2 = this._read_control_escape();
          if (address2 === FAILURE) {
            this._offset = index2;
            address2 = this._read_octal_escape();
            if (address2 === FAILURE) {
              this._offset = index2;
              address2 = this._read_hex_escape();
              if (address2 === FAILURE) {
                this._offset = index2;
                address2 = this._read_unicode_escape();
                if (address2 === FAILURE) {
                  this._offset = index2;
                  address2 = this._read_null_escape();
                  if (address2 === FAILURE) {
                    this._offset = index2;
                  }
                }
              }
            }
          }
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode14(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._charset_escape[index0] = [address0, this._offset];
      return address0;
    },

    _read_charset_range_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._charset_range_escape = this._cache._charset_range_escape || {};
      var cached = this._cache._charset_range_escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '\\') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::charset_range_escape', '"\\\\"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset;
        var index3 = this._offset, elements1 = new Array(2);
        var address3 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[bfnrtv]/.test(chunk1)) {
          address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address3 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::charset_range_escape', '[bfnrtv]']);
          }
        }
        if (address3 !== FAILURE) {
          elements1[0] = address3;
          var address4 = FAILURE;
          var index4 = this._offset;
          var chunk2 = null, max2 = this._offset + 0;
          if (max2 <= this._inputSize) {
            chunk2 = this._input.substring(this._offset, max2);
          }
          if (chunk2 === '') {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 0), this._offset, []);
            this._offset = this._offset + 0;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::charset_range_escape', '""']);
            }
          }
          if (address4 === FAILURE) {
            address4 = new TreeNode(this._input.substring(index4, index4), index4, []);
            this._offset = index4;
          }
          if (address4 !== FAILURE) {
            elements1[1] = address4;
          } else {
            elements1 = null;
            this._offset = index3;
          }
        } else {
          elements1 = null;
          this._offset = index3;
        }
        if (elements1 === null) {
          address2 = FAILURE;
        } else {
          address2 = new TreeNode17(this._input.substring(index3, this._offset), index3, elements1);
          this._offset = this._offset;
        }
        if (address2 === FAILURE) {
          this._offset = index2;
          address2 = this._read_control_escape();
          if (address2 === FAILURE) {
            this._offset = index2;
            address2 = this._read_octal_escape();
            if (address2 === FAILURE) {
              this._offset = index2;
              address2 = this._read_hex_escape();
              if (address2 === FAILURE) {
                this._offset = index2;
                address2 = this._read_unicode_escape();
                if (address2 === FAILURE) {
                  this._offset = index2;
                  address2 = this._read_null_escape();
                  if (address2 === FAILURE) {
                    this._offset = index2;
                  }
                }
              }
            }
          }
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode16(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._charset_range_escape[index0] = [address0, this._offset];
      return address0;
    },

    _read_charset_literal () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._charset_literal = this._cache._charset_literal || {};
      var cached = this._cache._charset_literal[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      var index2 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var index3 = this._offset;
      var chunk0 = null, max0 = this._offset + 0;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 0), this._offset, []);
        this._offset = this._offset + 0;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::charset_literal', '""']);
        }
      }
      if (address1 === FAILURE) {
        address1 = new TreeNode(this._input.substring(index3, index3), index3, []);
        this._offset = index3;
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[^\\\]]/.test(chunk1)) {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::charset_literal', '[^\\\\\\]]']);
          }
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index2;
        }
      } else {
        elements0 = null;
        this._offset = index2;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode18(this._input.substring(index2, this._offset), index2, elements0);
        this._offset = this._offset;
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        var index4 = this._offset, elements1 = new Array(2);
        var address3 = FAILURE;
        var chunk2 = null, max2 = this._offset + 1;
        if (max2 <= this._inputSize) {
          chunk2 = this._input.substring(this._offset, max2);
        }
        if (chunk2 === '\\') {
          address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address3 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::charset_literal', '"\\\\"']);
          }
        }
        if (address3 !== FAILURE) {
          elements1[0] = address3;
          var address4 = FAILURE;
          var index5 = this._offset;
          var chunk3 = null, max3 = this._offset + 1;
          if (max3 <= this._inputSize) {
            chunk3 = this._input.substring(this._offset, max3);
          }
          if (chunk3 === 'c') {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::charset_literal', '"c"']);
            }
          }
          this._offset = index5;
          if (address4 !== FAILURE) {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset), this._offset, []);
            this._offset = this._offset;
          } else {
            address4 = FAILURE;
          }
          if (address4 !== FAILURE) {
            elements1[1] = address4;
          } else {
            elements1 = null;
            this._offset = index4;
          }
        } else {
          elements1 = null;
          this._offset = index4;
        }
        if (elements1 === null) {
          address0 = FAILURE;
        } else {
          address0 = new TreeNode19(this._input.substring(index4, this._offset), index4, elements1);
          this._offset = this._offset;
        }
        if (address0 === FAILURE) {
          this._offset = index1;
          var index6 = this._offset, elements2 = new Array(2);
          var address5 = FAILURE;
          var chunk4 = null, max4 = this._offset + 1;
          if (max4 <= this._inputSize) {
            chunk4 = this._input.substring(this._offset, max4);
          }
          if (chunk4 === '\\') {
            address5 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address5 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::charset_literal', '"\\\\"']);
            }
          }
          if (address5 !== FAILURE) {
            elements2[0] = address5;
            var address6 = FAILURE;
            var chunk5 = null, max5 = this._offset + 1;
            if (max5 <= this._inputSize) {
              chunk5 = this._input.substring(this._offset, max5);
            }
            if (chunk5 !== null && /^[^bdDfnrsStvwW]/.test(chunk5)) {
              address6 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
              this._offset = this._offset + 1;
            } else {
              address6 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::charset_literal', '[^bdDfnrsStvwW]']);
              }
            }
            if (address6 !== FAILURE) {
              elements2[1] = address6;
            } else {
              elements2 = null;
              this._offset = index6;
            }
          } else {
            elements2 = null;
            this._offset = index6;
          }
          if (elements2 === null) {
            address0 = FAILURE;
          } else {
            address0 = new TreeNode20(this._input.substring(index6, this._offset), index6, elements2);
            this._offset = this._offset;
          }
          if (address0 === FAILURE) {
            this._offset = index1;
          }
        }
      }
      this._cache._charset_literal[index0] = [address0, this._offset];
      return address0;
    },

    _read_terminal () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._terminal = this._cache._terminal || {};
      var cached = this._cache._terminal[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '.') {
        address0 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address0 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::terminal', '"."']);
        }
      }
      if (address0 !== FAILURE) {
        Object.assign(address0, this._types.AnyCharacter);
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        address0 = this._read_escape();
        if (address0 !== FAILURE) {
          Object.assign(address0, this._types.Escape);
        }
        if (address0 === FAILURE) {
          this._offset = index1;
          address0 = this._read_literal();
          if (address0 !== FAILURE) {
            Object.assign(address0, this._types.Literal);
          }
          if (address0 === FAILURE) {
            this._offset = index1;
          }
        }
      }
      this._cache._terminal[index0] = [address0, this._offset];
      return address0;
    },

    _read_literal () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._literal = this._cache._literal || {};
      var cached = this._cache._literal[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset;
      var index2 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var index3 = this._offset;
      var chunk0 = null, max0 = this._offset + 0;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 0), this._offset, []);
        this._offset = this._offset + 0;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::literal', '""']);
        }
      }
      if (address1 === FAILURE) {
        address1 = new TreeNode(this._input.substring(index3, index3), index3, []);
        this._offset = index3;
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[^|\\/.\[\(\)?+*$^]/.test(chunk1)) {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::literal', '[^|\\\\/.\\[\\(\\)?+*$^]']);
          }
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index2;
        }
      } else {
        elements0 = null;
        this._offset = index2;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode21(this._input.substring(index2, this._offset), index2, elements0);
        this._offset = this._offset;
      }
      if (address0 === FAILURE) {
        this._offset = index1;
        var index4 = this._offset, elements1 = new Array(2);
        var address3 = FAILURE;
        var chunk2 = null, max2 = this._offset + 1;
        if (max2 <= this._inputSize) {
          chunk2 = this._input.substring(this._offset, max2);
        }
        if (chunk2 === '\\') {
          address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address3 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::literal', '"\\\\"']);
          }
        }
        if (address3 !== FAILURE) {
          elements1[0] = address3;
          var address4 = FAILURE;
          var index5 = this._offset;
          var chunk3 = null, max3 = this._offset + 1;
          if (max3 <= this._inputSize) {
            chunk3 = this._input.substring(this._offset, max3);
          }
          if (chunk3 === 'c') {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::literal', '"c"']);
            }
          }
          this._offset = index5;
          if (address4 !== FAILURE) {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset), this._offset, []);
            this._offset = this._offset;
          } else {
            address4 = FAILURE;
          }
          if (address4 !== FAILURE) {
            elements1[1] = address4;
          } else {
            elements1 = null;
            this._offset = index4;
          }
        } else {
          elements1 = null;
          this._offset = index4;
        }
        if (elements1 === null) {
          address0 = FAILURE;
        } else {
          address0 = new TreeNode22(this._input.substring(index4, this._offset), index4, elements1);
          this._offset = this._offset;
        }
        if (address0 === FAILURE) {
          this._offset = index1;
          var index6 = this._offset, elements2 = new Array(2);
          var address5 = FAILURE;
          var chunk4 = null, max4 = this._offset + 1;
          if (max4 <= this._inputSize) {
            chunk4 = this._input.substring(this._offset, max4);
          }
          if (chunk4 === '\\') {
            address5 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address5 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::literal', '"\\\\"']);
            }
          }
          if (address5 !== FAILURE) {
            elements2[0] = address5;
            var address6 = FAILURE;
            if (this._offset < this._inputSize) {
              address6 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
              this._offset = this._offset + 1;
            } else {
              address6 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::literal', '<any char>']);
              }
            }
            if (address6 !== FAILURE) {
              elements2[1] = address6;
            } else {
              elements2 = null;
              this._offset = index6;
            }
          } else {
            elements2 = null;
            this._offset = index6;
          }
          if (elements2 === null) {
            address0 = FAILURE;
          } else {
            address0 = new TreeNode23(this._input.substring(index6, this._offset), index6, elements2);
            this._offset = this._offset;
          }
          if (address0 === FAILURE) {
            this._offset = index1;
          }
        }
      }
      this._cache._literal[index0] = [address0, this._offset];
      return address0;
    },

    _read_control_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._control_escape = this._cache._control_escape || {};
      var cached = this._cache._control_escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === 'c') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::control_escape', '"c"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[a-zA-Z]/.test(chunk1)) {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::control_escape', '[a-zA-Z]']);
          }
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode24(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._control_escape[index0] = [address0, this._offset];
      return address0;
    },

    _read_octal_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._octal_escape = this._cache._octal_escape || {};
      var cached = this._cache._octal_escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '0') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::octal_escape', '"0"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset, elements1 = [], address3 = null;
        while (true) {
          var chunk1 = null, max1 = this._offset + 1;
          if (max1 <= this._inputSize) {
            chunk1 = this._input.substring(this._offset, max1);
          }
          if (chunk1 !== null && /^[0-7]/.test(chunk1)) {
            address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address3 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::octal_escape', '[0-7]']);
            }
          }
          if (address3 !== FAILURE) {
            elements1.push(address3);
          } else {
            break;
          }
        }
        if (elements1.length >= 1) {
          address2 = new TreeNode(this._input.substring(index2, this._offset), index2, elements1);
          this._offset = this._offset;
        } else {
          address2 = FAILURE;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode25(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._octal_escape[index0] = [address0, this._offset];
      return address0;
    },

    _read_hex_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._hex_escape = this._cache._hex_escape || {};
      var cached = this._cache._hex_escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === 'x') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::hex_escape', '"x"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset, elements1 = new Array(2);
        var address3 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[0-9a-fA-F]/.test(chunk1)) {
          address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address3 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::hex_escape', '[0-9a-fA-F]']);
          }
        }
        if (address3 !== FAILURE) {
          elements1[0] = address3;
          var address4 = FAILURE;
          var chunk2 = null, max2 = this._offset + 1;
          if (max2 <= this._inputSize) {
            chunk2 = this._input.substring(this._offset, max2);
          }
          if (chunk2 !== null && /^[0-9a-fA-F]/.test(chunk2)) {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::hex_escape', '[0-9a-fA-F]']);
            }
          }
          if (address4 !== FAILURE) {
            elements1[1] = address4;
          } else {
            elements1 = null;
            this._offset = index2;
          }
        } else {
          elements1 = null;
          this._offset = index2;
        }
        if (elements1 === null) {
          address2 = FAILURE;
        } else {
          address2 = new TreeNode(this._input.substring(index2, this._offset), index2, elements1);
          this._offset = this._offset;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode26(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._hex_escape[index0] = [address0, this._offset];
      return address0;
    },

    _read_unicode_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._unicode_escape = this._cache._unicode_escape || {};
      var cached = this._cache._unicode_escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === 'u') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::unicode_escape', '"u"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset, elements1 = new Array(4);
        var address3 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[0-9a-fA-F]/.test(chunk1)) {
          address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address3 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::unicode_escape', '[0-9a-fA-F]']);
          }
        }
        if (address3 !== FAILURE) {
          elements1[0] = address3;
          var address4 = FAILURE;
          var chunk2 = null, max2 = this._offset + 1;
          if (max2 <= this._inputSize) {
            chunk2 = this._input.substring(this._offset, max2);
          }
          if (chunk2 !== null && /^[0-9a-fA-F]/.test(chunk2)) {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
            this._offset = this._offset + 1;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::unicode_escape', '[0-9a-fA-F]']);
            }
          }
          if (address4 !== FAILURE) {
            elements1[1] = address4;
            var address5 = FAILURE;
            var chunk3 = null, max3 = this._offset + 1;
            if (max3 <= this._inputSize) {
              chunk3 = this._input.substring(this._offset, max3);
            }
            if (chunk3 !== null && /^[0-9a-fA-F]/.test(chunk3)) {
              address5 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
              this._offset = this._offset + 1;
            } else {
              address5 = FAILURE;
              if (this._offset > this._failure) {
                this._failure = this._offset;
                this._expected = [];
              }
              if (this._offset === this._failure) {
                this._expected.push(['JavaScriptRegexp::unicode_escape', '[0-9a-fA-F]']);
              }
            }
            if (address5 !== FAILURE) {
              elements1[2] = address5;
              var address6 = FAILURE;
              var chunk4 = null, max4 = this._offset + 1;
              if (max4 <= this._inputSize) {
                chunk4 = this._input.substring(this._offset, max4);
              }
              if (chunk4 !== null && /^[0-9a-fA-F]/.test(chunk4)) {
                address6 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
                this._offset = this._offset + 1;
              } else {
                address6 = FAILURE;
                if (this._offset > this._failure) {
                  this._failure = this._offset;
                  this._expected = [];
                }
                if (this._offset === this._failure) {
                  this._expected.push(['JavaScriptRegexp::unicode_escape', '[0-9a-fA-F]']);
                }
              }
              if (address6 !== FAILURE) {
                elements1[3] = address6;
              } else {
                elements1 = null;
                this._offset = index2;
              }
            } else {
              elements1 = null;
              this._offset = index2;
            }
          } else {
            elements1 = null;
            this._offset = index2;
          }
        } else {
          elements1 = null;
          this._offset = index2;
        }
        if (elements1 === null) {
          address2 = FAILURE;
        } else {
          address2 = new TreeNode(this._input.substring(index2, this._offset), index2, elements1);
          this._offset = this._offset;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode27(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._unicode_escape[index0] = [address0, this._offset];
      return address0;
    },

    _read_null_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._null_escape = this._cache._null_escape || {};
      var cached = this._cache._null_escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '0') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::null_escape', '"0"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset;
        var chunk1 = null, max1 = this._offset + 0;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 === '') {
          address2 = new TreeNode(this._input.substring(this._offset, this._offset + 0), this._offset, []);
          this._offset = this._offset + 0;
        } else {
          address2 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::null_escape', '""']);
          }
        }
        if (address2 === FAILURE) {
          address2 = new TreeNode(this._input.substring(index2, index2), index2, []);
          this._offset = index2;
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode28(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._null_escape[index0] = [address0, this._offset];
      return address0;
    },

    _read_escape () {
      var address0 = FAILURE, index0 = this._offset;
      this._cache._escape = this._cache._escape || {};
      var cached = this._cache._escape[index0];
      if (cached) {
        this._offset = cached[1];
        return cached[0];
      }
      var index1 = this._offset, elements0 = new Array(2);
      var address1 = FAILURE;
      var chunk0 = null, max0 = this._offset + 1;
      if (max0 <= this._inputSize) {
        chunk0 = this._input.substring(this._offset, max0);
      }
      if (chunk0 === '\\') {
        address1 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
        this._offset = this._offset + 1;
      } else {
        address1 = FAILURE;
        if (this._offset > this._failure) {
          this._failure = this._offset;
          this._expected = [];
        }
        if (this._offset === this._failure) {
          this._expected.push(['JavaScriptRegexp::escape', '"\\\\"']);
        }
      }
      if (address1 !== FAILURE) {
        elements0[0] = address1;
        var address2 = FAILURE;
        var index2 = this._offset;
        var index3 = this._offset, elements1 = new Array(2);
        var address3 = FAILURE;
        var chunk1 = null, max1 = this._offset + 1;
        if (max1 <= this._inputSize) {
          chunk1 = this._input.substring(this._offset, max1);
        }
        if (chunk1 !== null && /^[bBdDfnrsStvwW1-9]/.test(chunk1)) {
          address3 = new TreeNode(this._input.substring(this._offset, this._offset + 1), this._offset, []);
          this._offset = this._offset + 1;
        } else {
          address3 = FAILURE;
          if (this._offset > this._failure) {
            this._failure = this._offset;
            this._expected = [];
          }
          if (this._offset === this._failure) {
            this._expected.push(['JavaScriptRegexp::escape', '[bBdDfnrsStvwW1-9]']);
          }
        }
        if (address3 !== FAILURE) {
          elements1[0] = address3;
          var address4 = FAILURE;
          var index4 = this._offset;
          var chunk2 = null, max2 = this._offset + 0;
          if (max2 <= this._inputSize) {
            chunk2 = this._input.substring(this._offset, max2);
          }
          if (chunk2 === '') {
            address4 = new TreeNode(this._input.substring(this._offset, this._offset + 0), this._offset, []);
            this._offset = this._offset + 0;
          } else {
            address4 = FAILURE;
            if (this._offset > this._failure) {
              this._failure = this._offset;
              this._expected = [];
            }
            if (this._offset === this._failure) {
              this._expected.push(['JavaScriptRegexp::escape', '""']);
            }
          }
          if (address4 === FAILURE) {
            address4 = new TreeNode(this._input.substring(index4, index4), index4, []);
            this._offset = index4;
          }
          if (address4 !== FAILURE) {
            elements1[1] = address4;
          } else {
            elements1 = null;
            this._offset = index3;
          }
        } else {
          elements1 = null;
          this._offset = index3;
        }
        if (elements1 === null) {
          address2 = FAILURE;
        } else {
          address2 = new TreeNode30(this._input.substring(index3, this._offset), index3, elements1);
          this._offset = this._offset;
        }
        if (address2 === FAILURE) {
          this._offset = index2;
          address2 = this._read_control_escape();
          if (address2 === FAILURE) {
            this._offset = index2;
            address2 = this._read_octal_escape();
            if (address2 === FAILURE) {
              this._offset = index2;
              address2 = this._read_hex_escape();
              if (address2 === FAILURE) {
                this._offset = index2;
                address2 = this._read_unicode_escape();
                if (address2 === FAILURE) {
                  this._offset = index2;
                  address2 = this._read_null_escape();
                  if (address2 === FAILURE) {
                    this._offset = index2;
                  }
                }
              }
            }
          }
        }
        if (address2 !== FAILURE) {
          elements0[1] = address2;
        } else {
          elements0 = null;
          this._offset = index1;
        }
      } else {
        elements0 = null;
        this._offset = index1;
      }
      if (elements0 === null) {
        address0 = FAILURE;
      } else {
        address0 = new TreeNode29(this._input.substring(index1, this._offset), index1, elements0);
        this._offset = this._offset;
      }
      this._cache._escape[index0] = [address0, this._offset];
      return address0;
    }
  };

  var Parser = function(input, actions, types) {
    this._input = input;
    this._inputSize = input.length;
    this._actions = actions;
    this._types = types;
    this._offset = 0;
    this._cache = {};
    this._failure = 0;
    this._expected = [];
  };

  Parser.prototype.parse = function() {
    var tree = this._read_root();
    if (tree !== FAILURE && this._offset === this._inputSize) {
      return tree;
    }
    if (this._expected.length === 0) {
      this._failure = this._offset;
      this._expected.push(['JavaScriptRegexp', '<EOF>']);
    }
    this.constructor.lastError = { offset: this._offset, expected: this._expected };
    throw new SyntaxError(formatError(this._input, this._failure, this._expected));
  };

  Object.assign(Parser.prototype, Grammar);


  function parse(input, options) {
    options = options || {};
    var parser = new Parser(input, options.actions, options.types);
    return parser.parse();
  }

  function formatError(input, offset, expected) {
    var lines = input.split(/\n/g),
        lineNo = 0,
        position = 0;

    while (position <= offset) {
      position += lines[lineNo].length + 1;
      lineNo += 1;
    }

    var line = lines[lineNo - 1],
        message = 'Line ' + lineNo + ': expected one of:\n\n';

    for (var i = 0; i < expected.length; i++) {
      message += '    - ' + expected[i][1] + ' from ' + expected[i][0] + '\n';
    }
    var number = lineNo.toString();
    while (number.length < 6) number = ' ' + number;
    message += '\n' + number + ' | ' + line + '\n';

    position -= line.length + 10;

    while (position < offset) {
      message += ' ';
      position += 1;
    }
    return message + '^';
  }

  function inherit(subclass, parent) {
    function chain () {};
    chain.prototype = parent.prototype;
    subclass.prototype = new chain();
    subclass.prototype.constructor = subclass;
  }


  var exported = { Grammar: Grammar, Parser: Parser, parse: parse };

  if (typeof require === 'function' && typeof exports === 'object') {
    Object.assign(exports, exported);
  } else {
    var ns = (typeof this === 'undefined') ? window : this;
    ns.JavaScriptRegexp = exported;
  }
})();
