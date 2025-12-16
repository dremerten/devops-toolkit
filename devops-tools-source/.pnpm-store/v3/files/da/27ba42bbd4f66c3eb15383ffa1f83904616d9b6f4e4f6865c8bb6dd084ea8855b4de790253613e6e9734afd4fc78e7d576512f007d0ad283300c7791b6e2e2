"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RegexpNode = void 0;
var match_1 = require("./match");
var node_1 = require("./node");
var util_1 = require("./util");
var RegexpNode = /** @class */ (function (_super) {
    __extends(RegexpNode, _super);
    function RegexpNode(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        var alternates = _this.metadata.alternates;
        // Merge all the match nodes into one array.
        _this.matches = [_this.metadata.match]
            .concat(alternates.elements.map(function (e) { return e.match; }))
            .map(function (match) { return new match_1.MatchNode(match, _this); });
        // When there is only one match node to render, proxy to it.
        _this.proxy = alternates.elements.length === 0 ? _this.matches[0] : null;
        return _this;
    }
    RegexpNode.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var matchContainer, matches, containerBox, paths, connectorPaths;
            var _this = this;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        matchContainer = this.container
                            .group()
                            .addClass("".concat(this.type, "-matches"))
                            .translate(20, 0);
                        matches = this.matches;
                        // Renders each match into the match container.
                        return [4 /*yield*/, Promise.all(matches.map(function (match) { return match.render(matchContainer.group()); }))
                            // Space matches vertically in the match container.
                        ];
                    case 1:
                        // Renders each match into the match container.
                        _a.sent();
                        // Space matches vertically in the match container.
                        (0, util_1.spaceVertical)(matches, 5);
                        containerBox = this.bbox();
                        paths = [];
                        matches.forEach(function (match) {
                            return paths.push.apply(paths, _this.makeCurve(containerBox, match));
                        });
                        // Add side lines to the list of paths.
                        paths.push.apply(paths, this.makeSide(containerBox, matches[0]));
                        paths.push.apply(paths, this.makeSide(containerBox, matches[matches.length - 1]));
                        // Render connector paths.
                        this.container.path(paths.join('')).back();
                        containerBox = (0, util_1.normalizeBBox)(matchContainer.bbox());
                        connectorPaths = matches.map(function (match) {
                            return _this.makeConnector(containerBox, match);
                        });
                        matchContainer.path(connectorPaths.join('')).back();
                        return [2 /*return*/];
                }
            });
        });
    };
    /**
     * Returns an array of SVG path strings to draw the vertical lines on the
     * left and right of the node.
     * @param containerBox Bounding box of the container.
     * @param match Match node that the line will be drawn to.
     */
    RegexpNode.prototype.makeSide = function (containerBox, match) {
        var box = match.bbox();
        var distance = Math.abs(box.ay - containerBox.cy);
        // Only need to draw side lines if the match is more than 15 pixels from
        // the vertical center of the rendered regexp. Less that 15 pixels will be
        // handled by the curve directly.
        if (distance >= 15) {
            var shift = box.ay > containerBox.cy ? 10 : -10;
            var edge = box.ay - shift;
            return [
                "M0,".concat(containerBox.cy, "q10,0 10,").concat(shift, "V").concat(edge),
                "M".concat(containerBox.width + 40, ",").concat(containerBox.cy, "q-10,0 -10,").concat(shift, "V").concat(edge),
            ];
        }
    };
    /**
     * Returns an array of SVG path strings to draw the curves from the
     * sidelines up to the anchor of the match node.
     * @param containerBox Bounding box of the container.
     * @param match Match node that the line will be drawn to.
     */
    RegexpNode.prototype.makeCurve = function (containerBox, match) {
        var box = match.bbox();
        var distance = Math.abs(box.ay - containerBox.cy);
        if (distance >= 15) {
            // For match nodes more than 15 pixels from the center of the regexp, a
            // quarter-circle curve is used to connect to the sideline.
            var curve = box.ay > containerBox.cy ? 10 : -10;
            return [
                "M10,".concat(box.ay - curve, "q0,").concat(curve, " 10,").concat(curve),
                "M".concat(containerBox.width + 30, ",").concat(box.ay - curve, "q0,").concat(curve, " -10,").concat(curve),
            ];
        }
        // For match nodes less than 15 pixels from the center of the regexp, a
        // slightly curved line is used to connect to the sideline.
        var anchor = box.ay - containerBox.cy;
        return [
            "M0,".concat(containerBox.cy, "c10,0 10,").concat(anchor, " 20,").concat(anchor),
            "M".concat(containerBox.width + 40, ",").concat(containerBox.cy, "c-10,0 -10,").concat(anchor, " -20,").concat(anchor),
        ];
    };
    /**
     * Returns an array of SVG path strings to draw the connection from the
     * curve to match node.
     * @param containerBox Bounding box of the container.
     * @param match Match node that the line will be drawn to.
     */
    RegexpNode.prototype.makeConnector = function (containerBox, match) {
        var box = match.bbox();
        return "M0,".concat(box.ay, "h").concat(box.ax, "M").concat(box.ax2, ",").concat(box.ay, "H").concat(containerBox.width);
    };
    return RegexpNode;
}(node_1.Node));
exports.RegexpNode = RegexpNode;
//# sourceMappingURL=regexp.js.map