#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns plugins.outlook
  (:require [babashka.process :refer [sh]]
            [cheshire.core :as json]
            [sketchybar.core :as sketchybar]
            [clojure.string]
            [taoensso.timbre :as log]))

(defn number-string? [string]
  (every? #(Character/isDigit %) string))

(defn get-message-count []
  (let [plain (:out (sh "lsappinfo info -only StatusLabel" (:out (sh "lsappinfo find LSDisplayName='Microsoft Outlook'"))))] ; 
    (if (or (nil? plain) (= "" plain)) 0
        (let [status (json/parse-string (clojure.string/replace (re-find #"\{.*" plain) "=" ":") true)] ; 
          (if (= (:label status) "") 0 (if (number-string? (:label status)) (read-string (:label status)) 1))))))

(defn refresh []
  (try
    (let [count (get-message-count)]
      (log/debug (str "updating outlook. Message count: " count))
      (sketchybar/exec (sketchybar/set :outlook (if (> count 0)
                                                  {:label count :drawing "on"}
                                                  {:drawing "off"}))))
    (catch Exception ex (log/error ex "error while updating outlook notification count"))))

(refresh)
