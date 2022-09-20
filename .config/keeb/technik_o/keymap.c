// MIT License
//
// Copyright (c) 2021 David Stangl
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#include QMK_KEYBOARD_H

enum layers {
    _QWERTY,
    _NUMBER,
    _SYMBOL,
    _NAVIGATE,
};

#define CTRL_ESC LCTL_T(KC_ESC)
#define NUMBER_SPC LT(_NUMBER, KC_SPC)
#define NUMBER MO(_NUMBER)
#define SYMBOL_ENTER LT(_SYMBOL, KC_ENTER)
#define NAVIGATE MO(_NAVIGATE)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [_QWERTY] = LAYOUT_ortho_4x12(
      KC_TAB,   KC_Q,    KC_W,    KC_E,    KC_R,   KC_T,       KC_Y,         KC_U,     KC_I,    KC_O,    KC_P,    KC_BSPC,
      CTRL_ESC, KC_A,    KC_S,    KC_D,    KC_F,   KC_G,       KC_H,         KC_J,     KC_K,    KC_L,    KC_SCLN, KC_QUOT,
      KC_LSPO,  KC_Z,    KC_X,    KC_C,    KC_V,   KC_B,       KC_N,         KC_M,     KC_COMM, KC_DOT,  KC_SLSH, KC_RSPC,
      _______,  KC_LGUI, _______, KC_LALT, KC_SPC, NUMBER_SPC, SYMBOL_ENTER, NAVIGATE, KC_RALT, _______, _______, _______
  ),

  [_NUMBER] = LAYOUT_ortho_4x12(
      _______, KC_F1,    KC_F2,    KC_F3,    KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_DEL,
      _______, KC_1,     KC_2,     KC_3,     KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    _______,
      _______, KC_MINUS, KC_EQUAL, KC_GRAVE, KC_BSLS, _______, _______, _______, _______, _______, _______, _______,
      _______, _______,  _______,  _______,  _______, _______, _______, _______, _______, _______, _______, _______
  ),

  [_SYMBOL] = LAYOUT_ortho_4x12(
      _______, KC_F11,  KC_F12,  KC_F13,   KC_F14,  KC_F15,  KC_F16,  KC_F17,  KC_F18,  KC_F19,  KC_F20,  _______,
      _______, S(KC_1), S(KC_2), S(KC_3),  S(KC_4), S(KC_5), S(KC_6), S(KC_7), S(KC_8), S(KC_9), S(KC_0), _______,
      _______, KC_UNDS, KC_PLUS, KC_TILDE, KC_PIPE, _______, _______, KC_LCBR, KC_RCBR, KC_LBRC, KC_RBRC, _______,
      _______, _______, _______, _______,  _______, _______, _______, _______, _______, _______, _______, _______
  ),

  [_NAVIGATE] = LAYOUT_ortho_4x12(
      _______, KC_PSCR, KC_VOLD, KC_MUTE,    KC_VOLU,    KC_BRIU,    KC_MS_LEFT, KC_MS_DOWN, KC_MS_UP, KC_MS_RIGHT, KC_MS_WH_UP,   _______,
      _______, _______, KC_MPRV, KC_MPLY,    KC_MNXT,    KC_BRID,    KC_LEFT,    KC_DOWN,    KC_UP,    KC_RIGHT,    KC_MS_WH_DOWN, _______,
      _______, _______, _______, _______,    _______,    _______,    KC_HOME,    KC_PGDN,    KC_PGUP,  KC_END,      _______,       _______,
      _______, _______, _______, KC_MS_BTN3, KC_MS_BTN2, KC_MS_BTN1, _______,    _______,    _______,  _______,     _______,       RESET
  ),
};
